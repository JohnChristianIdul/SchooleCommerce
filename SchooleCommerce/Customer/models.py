from django.db import models
from Person.models import Person
from SchoolAdmin.models import SchoolAdmin
from Transaction.models import Transactions


# Create your models here.
class Customer(Person):
    customer_ID = models.AutoField(primary_key=True, null=False)
    school_admin_ID = models.ForeignKey(SchoolAdmin, on_delete=models.CASCADE)
    customer_wallet = models.FloatField(default=0.0)
    transaction_history = models.ManyToManyField(Transactions)


class Report(models.Model):
    pass





