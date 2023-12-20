import json
from django.http import HttpResponse, HttpResponseRedirect, JsonResponse
from django.views import View
from django.shortcuts import render, redirect
from .forms import CustomerRegisterForm
from Product.models import Product, ProductReview
from django.db import connection



class SignUpView(View):
    template_name = 'signup.html'

    def get(self, request):
        form = CustomerRegisterForm()
        return render(request, self.template_name, {'form': form})

    def post(self, request):
        form = CustomerRegisterForm(request.POST)

        if form.is_valid():
            # Custom save method using modified stored procedure
            message = form.save_with_stored_procedure()

            if message == 'Success':
                return redirect('login')
            else:
                return HttpResponse(f'Duplicate Username: {message}', status=400)

        return render(request, self.template_name, {'form': form})


class LoginView(View):
    template = "login.html"

    def get(self, request):
        return render(request, self.template)

    def post(self, request):
        uname = request.POST['Username']
        pwd = request.POST['Password']
        cursor = connection.cursor()
        args = [uname, pwd]
        cursor.callproc('ValidateLogin', args)
        result = cursor.fetchall()
        cursor.close()
        if (result[0][0] == 0):
            msg = 'Incorrect username or password'
            return render(request, self.template, {'msg': msg})
        else:
            request.session['username'] = uname
            return HttpResponseRedirect('home')


class HomeView(View):
    template_name = 'home.html'

    def get(self, request):
        products = Product.objects.all()
        return render(request, self.template_name, {'products': products})


class ItemView(View):
    template_name = 'selectitem.html'

    def get_product_data(self, product_id):
        with connection.cursor() as cursor:
            cursor.callproc('GetItemData', [product_id])
            result = cursor.fetchall()
            if result:
                return result  # Returning a list
            else:
                return []

    def get_product_reviews(self, product_id):
        with connection.cursor() as cursor:
            cursor.callproc('GetProductReviews', [product_id])
            result = cursor.fetchall()
            return result

    def get(self, request, product_id):
        try:
            product_data = self.get_product_data(product_id)
            product_reviews = self.get_product_reviews(product_id)

            if product_data:
                return render(request, self.template_name, {'product_data': product_data, 'product_reviews': product_reviews})
            else:
                return HttpResponse(f'No data found for product ID {product_id}', status=400)
        except Exception as e:
            return HttpResponse(f'Error: {e}', status=500)


class CartView(View):
    pass


class CheckoutView(View):
    template_name = 'checkout.html'

    def get(self, request):
        # Assuming you have saved the customer_id in the session
        customer_id = request.session.get('customer_id', None)

        if customer_id is None:
            # Handle the case where customer_id is not found in the session
            return render(request, 'error.html', {'error_message': 'Customer ID not found'})

        with connection.cursor() as cursor:
            cursor.callproc('GetCheckoutData', [customer_id])
            checkout_data = cursor.fetchall()

        return render(request, self.template_name, {'checkout_data': checkout_data})