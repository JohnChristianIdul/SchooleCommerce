from django.urls import path
from . import views

app_name = 'Customer'

urlpatterns = [
    path('register', views.CustomerRegister.as_view(), name='CustomerRegister'),
    path('login', views.CustomerLogin.as_view(), name='CustomerLogin')
]
