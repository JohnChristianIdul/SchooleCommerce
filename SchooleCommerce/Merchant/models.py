from django.db import models
from Person.models import Person


# Create your models here.
class Merchant(Person):
    merchant_ID = models.CharField(primary_key=True)
    pass


class CustomerSupport(models.Model):
    pass



class OrderConfirmation(models.Model):
    pass
