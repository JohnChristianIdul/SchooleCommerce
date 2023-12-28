from django.contrib import messages
from django.shortcuts import render
from .forms import (DeliveryPersonnelLoginFrm, DeliveryPersonnelRegFrm,
                    CourierRegFrm, CourierLoginFrm, CourierOrderDpForm)
from django.db import connection, connections
from django.views.generic.base import View
from django.shortcuts import redirect
from datetime import datetime
from .models import CourierOrderDp


# Create your views here.
class DSignUpView(View):
    template_name = 'registerD.html'

    def register_deliverypersonnel(self, cleaned_data):
        args = [
            cleaned_data['username'],
            cleaned_data['password'],
            cleaned_data['name'],
            cleaned_data['address'],
            cleaned_data['email'],
            cleaned_data['contact_number'],
            'D'
        ]

        with connection.cursor() as cursor:
            cursor.callproc('registerD', args)

            output_param_value = args[-1]
            results = cursor.fetchall()
            print(results)

        return results, output_param_value

    def get(self, request):
        form = DeliveryPersonnelRegFrm()
        return render(request, self.template_name, {'form': form})

    def post(self, request):
        form = DeliveryPersonnelRegFrm(request.POST)

        if form.is_valid():
            results, output_param_value = self.register_deliverypersonnel(form.cleaned_data)

            result_message = results[0][0] if results and results[0] else None

            if result_message == 'Success':
                return redirect('d-home')
            else:
                form.add_error(None, result_message)
                return render(request, self.template_name, {'form' : form, 'error_message': 'Duplicate username. Please choose a different one.'})
        else:
            return render(request, self.template_name, {'form': form})

class DLoginView(View):
    template = "loginD.html"

    def get(self, request):
        return render(request, self.template)

    def post(self, request):
        username = request.POST.get('Username', '')
        password = request.POST.get('Password', '')

        try:
            with connection.cursor() as cursor:
                args = [username, password]
                cursor.callproc('checkcredentialsD', args)
                result = cursor.fetchall()

            if result and result[0][0] == 'login successful':
                request.session['username'] = username
                return redirect('d-home')
            else:
                msg = 'Incorrect username or password'
                messages.error(request, msg)
                return render(request, self.template, {'msg': msg})

        except Exception as e:
            # Handle database errors or other exceptions
            print(f"An error occurred: {e}")
            msg = 'An error occurred. Please try again.'
            messages.error(request, msg)
            return render(request, self.template, {'msg': msg})




class TSignUpView(View):
    template_name = 'registerT.html'

    def register_courier(self, cleaned_data):
        args = [
            cleaned_data['username'],
            cleaned_data['password'],
            cleaned_data['name'],
            cleaned_data['address'],
            cleaned_data['email'],
            cleaned_data['contact_number'],
            'T',
        ]

        with connection.cursor() as cursor:
            cursor.callproc('registerT', args)

            output_param_value = args[-1]
            results = cursor.fetchall()
            print(results)

        return results, output_param_value

    def get(self, request):
        form = CourierRegFrm()
        return render(request, self.template_name, {'form': form})

    def post(self, request):
        form = CourierRegFrm(request.POST)

        if form.is_valid():
            results, output_param_value = self.register_courier(form.cleaned_data)

            result_message = results[0][0] if results and results[0] else None

            if result_message == 'Success':
                return redirect('t-home')
            else:
                form.add_error(None, result_message)
                return render(request, self.template_name, {'form' : form, 'error_message': 'Duplicate username. Please choose a different one.'})
        else:
            return render(request, self.template_name, {'form': form})


class TLoginView(View):
    template = "loginT.html"

    def get(self, request):
        return render(request, self.template)

    def post(self, request):
        username = request.POST.get('Username', '')
        pwd = request.POST.get('Password', '')

        try:
            with connections['default'].cursor() as cursor:
                args = [username, pwd]
                cursor.callproc('checkcredentialsT', args)
                result = cursor.fetchall()

                if result and result[0][0] == 'login successful':
                    request.session['username'] = username
                    return redirect('t-home')  # Redirect to Thome view
                else:
                    msg = 'Incorrect username or password'
                    return render(request, self.template, {'msg': msg})

        except connections['default'].DatabaseError as e:
            print(f"An error occurred: {e}")
            msg = 'An error occurred. Please try again.'
            return render(request, self.template, {'msg': msg})

        # cursor = connection.cursor()
        # args = [uname, pwd]
        # cursor.callproc('checkcredentialsT', args)
        # result = cursor.fetchall()
        # cursor.close()
        # print(result)
        #
        # if result and result[0][0] == 'login successful':
        #     request.session['username'] = uname
        #     return redirect('t-home')
        # else:
        #     msg = 'Incorrect username or password'
        #     return render(request, self.template, {'msg': msg})


class Dhome(View):
    template_name = 'homeD.html'

    def get(self, request):
        # Get the username from the session
        username = request.session.get('username')
        print(username)

        # Call the stored procedure to get the delivery_personnel_ID
        try:
            with connection.cursor() as cursor:
                args = [username]
                cursor.callproc('GetDeliveryPersonnelID', args)

                # Fetch the result set directly
                result = cursor.fetchone()

                if result:
                    # The result is not None, so it should be safe to access the delivery_personnel_id
                    delivery_personnel_id = result[0]
                    print(delivery_personnel_id)

            # Open a new cursor block for the second stored procedure call
            with connection.cursor() as cursor:
                # Call another stored procedure to get delivery orders
                cursor.callproc('GetDeliveryOrders', [delivery_personnel_id])
                delivery_orders_data = cursor.fetchall()

        except Exception as e:
            # Handle database errors or other exceptions
            print(f"An error occurred: {e}")
            delivery_orders_data = []

        # Pass 'username' to the template context
        context = {'delivery_orders_data': delivery_orders_data, 'username': username}
        return render(request, self.template_name, context)






class Thome(View):
    template_name = 'homeT.html'

    def get(self, request):
        # Retrieve the username from the session
        username = request.session.get('username')
        print(f"Username: {username}")

        # Initialize data variables
        personnel_name = ''
        delivery_personnel_data = []

        try:
            with connections['default'].cursor() as cursor:
                # Call the stored procedure to get the name based on the username
                args = [username, '']
                cursor.callproc('GetCourierName', args)
                result = cursor.fetchone()
                print(f"Result of GetCourierName: {result}")

                if result:
                    personnel_name = result[1]
                    print(f"Personnel Name: {personnel_name}")

            with connection.cursor() as cursor:
                if 't-home' in request.get_full_path():
                    # Always fetch the latest data from GetAllDeliveryPersonnel
                    cursor.nextset()  # Move to the next result set
                    cursor.callproc('GetAllDeliveryPersonnel')
                    delivery_personnel_result = cursor.fetchall()

                    # Prepare the delivery personnel data
                    for row in delivery_personnel_result:
                        delivery_personnel_data.append({
                            'delivery_personnel_ID': row[0],
                            'name': row[1],
                            'contact_number': row[2],
                            'email': row[3],
                            'address': row[4],
                        })

        except connections['default'].DatabaseError as e:
            print(f"Database error occurred: {e}")

        context = {'username': username, 'personnel_name': personnel_name, 'delivery_personnel_data': delivery_personnel_data}
        return render(request, self.template_name, context)



# def courier_order_dp(request):
#     if request.method == 'POST':
#         form = CourierOrderDpForm(request.POST)
#         if form.is_valid():
#             # Save the form data to the model
#             form.save()
#
#             # Call the stored procedure to add the new order dp
#             cursor = connection.cursor()
#             args = [
#                 form.cleaned_data['delivery_date'],
#                 form.cleaned_data['commission'],
#             ]
#
#             try:
#                 # Call your stored procedure here (replace 'AddCourierOrderDP' with your actual stored procedure name)
#                 cursor.callproc('AddCourierOrderDP', args)
#
#                 # Display a success message
#                 messages.success(request, 'Successfully Added')
#
#                 # Redirect to 'homeT' after successfully creating the courier order
#                 return redirect('t-home')  # Replace 'homeT' with your actual homeT URL name
#             except Exception as e:
#                 # Log the error or handle it in a way that suits your application
#                 print(f"Error calling stored procedure: {str(e)}")
#
#
#             # Redirect to 'courierorderdp' in case of an error
#             return redirect('t-home')  # Replace 'courier-delivery' with your actual courier delivery URL name
#
#     else:
#         form = CourierOrderDpForm()
#
#     return render(request, 'addDpOrder.html', {'form': form})
def get_all_cart_checkouts(request):
    # Call the stored procedure to get all cart checkouts
    cursor = connection.cursor()
    cursor.callproc('GetAllCartCheckouts')
    cart_checkouts = cursor.fetchall()
    cursor.close()
    print(cart_checkouts)

    # Pass the retrieved data to the template
    return render(request, 'orders.html', {'cart_checkouts': cart_checkouts})


def update_delivery_status(request, order_id):
    order = CourierOrderDp.objects.get(order_ID_id=order_id)

    if request.method == 'POST':
        new_status = int(request.POST.get('delivery_status', 0))
        order.delivery_status = new_status

        # Get the date_delivered from the form
        date_delivered_str = request.POST.get('date_delivered', '')
        if date_delivered_str:
            order.date_delivered = datetime.strptime(date_delivered_str, '%Y-%m-%d').date()
        else:
            order.date_delivered = None

        order.save()

        # Call the stored procedure to update delivery status
        with connection.cursor() as cursor:
            cursor.callproc('UpdateDeliveryStatus', [order_id, new_status, order.date_delivered])
            connection.commit()  # Commit changes to the database

        return redirect('d-home')  # Redirect to the delivery orders page

    return render(request, 'updateOrderStatus.html', {'order_id': order.order_ID_id})


def addDpOrder(request):
    if request.method == 'POST':
        form = CourierOrderDpForm(request.POST)
        if form.is_valid():
            # Extract form data
            delivery_personnel_ID = form.cleaned_data['delivery_personnel_ID']
            order_ID = form.cleaned_data['order_ID']
            est_delivery_date = form.cleaned_data['est_delivery_date']

            # Call the stored procedure to insert data into deliverypersonnel_courierorderdp
            with connection.cursor() as cursor:
                cursor.callproc(
                    'AddDeliveryOrder',
                    [delivery_personnel_ID, order_ID, est_delivery_date, 0, 0, None]
                )
                connection.commit()  # Commit changes to the database

            # Add a success message
            messages.success(request, 'Delivery order added successfully.')

            # Redirect to 't-home' with a query parameter to indicate table refresh
            return redirect('t-home')

    else:
        form = CourierOrderDpForm()

    return render(request, 'addDelivery.html', {'form': form})


def getDelivery(request):

    return render(request, 'delivery.html', {'form': form})