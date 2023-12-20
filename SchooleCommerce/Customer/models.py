from django.db import models
from Person.models import Person
from SchoolAdmin.models import SchoolAdmin


# Create your models here.
class Customer(Person):
    customer = models.AutoField(primary_key=True)
    school_admin = models.ForeignKey(SchoolAdmin, on_delete=models.CASCADE)
    customer_wallet = models.FloatField(default=0.0)
    transaction_history = models.ManyToManyField('Transaction.Transactions', related_name='customer_history')

    USERNAME_FIELD = 'username'

    def __str__(self):
        return f"Customer {self.customer}: {self.name}"
