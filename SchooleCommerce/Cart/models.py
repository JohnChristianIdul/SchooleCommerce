from datetime import timedelta, datetime
from django.db import models
from Product.models import Product
from Customer.models import Customer
from Merchant.models import Merchant


# Create your models here.
class Cart(models.Model):
    cart_ID = models.AutoField(primary_key=True, null=False)
    customer_ID = models.ForeignKey(Customer, on_delete=models.CASCADE)
    total_amount = models.FloatField()

    def add_total_amount(self):
        # Get all related CartProductList objects
        cart_product_list_items = CartProductList.objects.filter(cart_ID=self)

        # Initialize the total amount
        total_amount = 0.0

        # Calculate the total amount by summing the subtotals
        for cart_product in cart_product_list_items:
            total_amount += cart_product.subtotal

        # Update the product_total_amount field with the calculated total amount
        self.total_amount = total_amount
        self.save()


class ProductQuantity(models.Model):
    product_ID = models.ForeignKey(Product.Product, on_delete=models.CASCADE)
    quantity = models.IntegerField(null=False)
    product_subtotal = models.FloatField(null=True)  # Field to store the subtotal

    def prod_subtotal(self):
        # Get the product price from the related Product object
        product_price = self.product_ID.product_price

        # Calculate the subtotal by multiplying quantity and product_price
        quantity_float = float(self.quantity)
        subtotal = quantity_float * product_price

        # Update the product_subtotal field with the calculated subtotal
        self.product_subtotal = subtotal
        self.save()


class CartProductList(models.Model):
    objects = models.Manager()
    cart_product_list_ID = models.AutoField(primary_key=True)
    cart_ID = models.ForeignKey(Cart, on_delete=models.CASCADE)
    product_ID = models.ForeignKey(Product, on_delete=models.SET_NULL, null=True)
    product_quantity = models.ForeignKey(ProductQuantity, on_delete=models.CASCADE)


class Checkout(models.Model):
    payMethod = {("G", "GCash"), ("B", "Online Bank"), ("C", "CoD")}
    check_out_ID = models.AutoField(primary_key=True)
    customer_ID = models.ForeignKey(Customer, on_delete=models.CASCADE)
    merchant_ID = models.ForeignKey(Merchant, on_delete=models.CASCADE)
    subtotal = models.FloatField(null=False)
    payment_method = models.CharField(max_length=1, choices=payMethod)
    receive_by_date = models.DateTimeField()

    def total_amount(self):
        cart_product_list = CartProductList.objects.filter(checkout=self)
        total = sum(cart.subtotal for cart in cart_product_list)
        self.subtotal = total

    def set_receive_by_date(self):
        # Calculate the receive_by_date as current time + 1 week
        self.receive_by_date = datetime.now() + timedelta(weeks=1)

    # Override the save method to call set_receive_by_date before saving
    def save(self, *args, **kwargs):
        self.set_receive_by_date()
        super().save(*args, **kwargs)


class Order(models.Model):
    pass


class OrderStatus(models.Model):
    pass

