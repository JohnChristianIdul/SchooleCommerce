from django.http import HttpResponse
from django.shortcuts import render, redirect
from django.template import loader
from django.views import View
from .form import CustomerRegisterForm, CustomerLoginForm


# Create your views here.
def index(request):
    return HttpResponse("Hi")


class CustomerRegister(View):
    template_name = "CustomerRegistration.html"

    def get(self, request):
        customerreg = CustomerRegisterForm()
        return render(request, self.template_name, {'form': customerreg})


class CustomerLogin(View):
    template = "CustomerLogin.html"

    def get(self, request):
        customerlogin = CustomerLoginForm()
        return render(request, self.template, {'form': customerlogin})
