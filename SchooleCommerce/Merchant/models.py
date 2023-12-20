from django.db import models
from Person.models import Person
from Transaction.models import Transactions


class Merchant(Person):
    merchant_ID = models.BigAutoField(primary_key=True)
    verification_status = models.BooleanField(default=False)
    merchant_wallet = models.FloatField(default=0)
    transaction_history = models.ManyToManyField('Transaction.Transactions', related_name='merchant_history')
    person_type = models.CharField(default="M", max_length=1)
