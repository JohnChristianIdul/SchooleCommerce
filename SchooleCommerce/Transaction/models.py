from django.db import models
from datetime import datetime


# Create your models here.
class Transactions(models.Model):
    transaction_ID = models.IntegerField(primary_key=True)
    customer = models.ForeignKey('Customer.Customer', related_name='customer_history', on_delete=models.CASCADE)
    merchant = models.ForeignKey('Merchant.Merchant', related_name='merchant_history', on_delete=models.CASCADE)
    transaction_type = models.CharField(max_length=1)
    amount = models.FloatField(default=0)
    transaction_date = models.DateField(default=datetime.now())



