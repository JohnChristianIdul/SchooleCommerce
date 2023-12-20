from django.db import models
from Customer.models import Customer
from datetime import datetime


# Create your models here.
class Product(models.Model):
    product_ID = models.AutoField(primary_key=True)
    product_name = models.CharField(max_length=100)
    product_details = models.TextField()
    product_price = models.DecimalField(max_digits=10, decimal_places=2)
    product_availability = models.BooleanField()
    product_stock = models.IntegerField()
    merchant_ID = models.ForeignKey('Merchant.Merchant', on_delete=models.CASCADE)


class ProductReview(models.Model):
    rating = [(1, 1), (2, 2), (3, 3), (4, 4), (5, 5)]
    product_review_ID = models.AutoField(primary_key=True)
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
    product = models.ForeignKey('Product.Product', on_delete=models.CASCADE)
    order = models.ForeignKey('Cart.Order', on_delete=models.CASCADE)
    product_Rating = models.IntegerField(choices=rating)
    review = models.CharField(max_length=1000)
    review_date = models.DateField(default=datetime.now())


