from datetime import timedelta, datetime
from django.db import models
from Product.models import Product
from Customer.models import Customer
from Merchant.models import Merchant


# Create your models here.
class Cart(models.Model):
    cart_ID = models.AutoField(primary_key=True, null=False)
    customer_ID = models.ForeignKey(Customer, on_delete=models.CASCADE)
    partial_total_amount = models.FloatField() #without shipping fee

    def add_total_amount(self):
        # Get all related CartProductList objects
        cart_product_list_items = CartProductList.objects.filter(cart_ID=self)

        # Initialize the total amount
        total_amount = 0.0

        # Calculate the total amount by summing the subtotals
        for cart_product in cart_product_list_items:
            total_amount += cart_product.subtotal

        # Update the product_total_amount field with the calculated total amount
        self.partial_total_amount = total_amount
        self.save()

    def __str__(self):
        return self.cart_ID


class ProductQuantity(models.Model):
    objects = models.Manager()
    product_ID = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.IntegerField(null=False)
    product_subtotal = models.FloatField(null=False, default=0.0)  # Field to store the subtotal

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
    cart_ID = models.ForeignKey(Cart, on_delete=models.CASCADE)
    product_ID = models.ForeignKey(Product, on_delete=models.SET_NULL, null=True)
    product_quantity_ID = models.ForeignKey(ProductQuantity, on_delete=models.CASCADE)
    total_quantity = models.IntegerField(null=False)
    cart_subtotal = models.FloatField(null=False)

    def calculate_total(self):
        # Get the total of all product_quantity
        product_quantities = ProductQuantity.objects.filter(cartproductlist=self)
        product_prices = ProductQuantity.objects.filter(cartproductlist=self)

        # Save it to total_quantity
        self.cart_subtotal = sum(product_price.product_subtotal for product_price in product_prices)
        self.total_quantity = sum(product_quantity.quantity for product_quantity in product_quantities)
        self.save()


class Checkout(models.Model):
    shipping_fee = 100.0
    payMethod = {("G", "GCash"), ("B", "Online Bank"), ("C", "CoD")}
    check_out_ID = models.AutoField(primary_key=True)
    customer_ID = models.ForeignKey(Customer, on_delete=models.CASCADE)
    merchant_ID = models.ForeignKey(Merchant, on_delete=models.CASCADE)
    total = models.FloatField(null=False)
    payment_method = models.CharField(max_length=1, choices=payMethod)
    receive_by_date = models.DateTimeField()

    def total_amount(self):
        cart_product_list = CartProductList.objects.filter(checkout=self)
        total = sum(cart.subtotal for cart in cart_product_list)
        self.total = total + self.shipping_fee
        self.save()

    def set_receive_by_date(self):
        # Calculate the receive_by_date as current time + 1 week
        self.receive_by_date = datetime.now() + timedelta(weeks=1)
        self.save()

    # Override the save method to call set_receive_by_date before saving
    def save(self, *args, **kwargs):
        self.set_receive_by_date()
        super().save(*args, **kwargs)

    def __str__(self):
        return self.check_out_ID


class Order(models.Model):
    pass


class OrderStatus(models.Model):
    pass

