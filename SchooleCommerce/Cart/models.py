from django.db import models
from Product.models import Product
from Customer.models import Customer
from Merchant.models import Merchant
from datetime import datetime, timedelta


# Create your models here.
class Cart(models.Model):
    cart_ID = models.AutoField(primary_key=True)
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.IntegerField()
    price = models.FloatField()
    subtotal = models.FloatField()

    def __str__(self):
        return f"Cart {self.cart_ID}"


class Checkout(models.Model):
    payment_method_choices = [
        ('GCash', 'GCash'),
        ('Online Bank', 'Online Bank'),
        ('CoD', 'Cash on Delivery'),
    ]

    checkout_ID = models.AutoField(primary_key=True)
    cart = models.ForeignKey(Cart, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    total_amount = models.FloatField()
    payment_method = models.CharField(max_length=20, choices=payment_method_choices)
    receive_by_date = models.DateField(default=datetime.now() + timedelta(days=7))
    order_date = models.DateField(datetime.now())
    confirm_order = models.BooleanField(default=False)

    def __str__(self):
        return f"Checkout {self.checkout_ID}"


class Order(models.Model):
    order_ID = models.AutoField(primary_key=True)
    checkout = models.ForeignKey(Checkout, on_delete=models.CASCADE)

    def __str__(self):
        return f"Order {self.order_ID}"


class OrderStatus(models.Model):
    order_status_ID = models.BigAutoField(primary_key=True)
    order = models.ForeignKey(Order, on_delete=models.CASCADE)
    order_status_change = models.DateTimeField()
    choices = [("Order Placed", "Order Placed"),
               ("Order Confirmed", "Order Confirmed"),
               ("Order Preparing", "Order Preparing"),
               ("Order Packaging", "Order Packaging")]
    order_status = models.CharField(max_length=30, choices=choices)

    def __str__(self):
        return f'{self.order_status_ID}'

