from django.urls import path
from .views import SignUpView, LoginView, HomeView, ItemView, CartView, CheckoutView

urlpatterns = [
    path('signup', SignUpView.as_view(), name='signup'),
    path('login', LoginView.as_view(), name='login'),
    path('home', HomeView.as_view(), name='home'),
    path('item/<int:product_id>/', ItemView.as_view(), name='item'),
    path('cart', CartView.as_view(), name='cart'),
    path('checkout', CheckoutView.as_view(), name='checkout')
    # Add other URL patterns as needed
]
