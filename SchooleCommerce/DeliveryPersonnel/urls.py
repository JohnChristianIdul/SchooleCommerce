from django.urls import path
from .views import *

urlpatterns = [
    path('delivery-register/', DSignUpView.as_view(), name='delivery-register'),
    path('delivery-login/', DLoginView.as_view(), name='delivery-login'),
    path('courier-register/', TSignUpView.as_view(), name='courier-register'),
    path('courier-login/', TLoginView.as_view(), name='courier-login'),
    path('d-home/', Dhome.as_view(), name='d-home'),
    path('t-home/', Thome.as_view(), name='t-home'),
    path('order-details/', get_all_cart_checkouts, name='order-details'),
    path('update-ds/<int:order_id>/', update_delivery_status, name='update-ds'),
    path('add-delivery/', addDpOrder, name='add-delivery'),
]