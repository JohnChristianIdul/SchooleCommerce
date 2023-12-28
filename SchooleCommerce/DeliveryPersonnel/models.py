from django.db import models
from Person.models import Person
from Cart.models import Checkout
from Customer.models import Customer

# Create your models here.
class DeliveryPersonnel(Person):
    delivery_personnel_ID = models.BigAutoField(primary_key=True)

    def __str__(self):
        return f"{self.delivery_personnel_ID}"


class Courier(Person):
    courier_ID = models.BigAutoField(primary_key=True)
    commission = models.FloatField(default=50.0)

    def __str__(self):
        return f"{self.name}"


class CourierOrderDp(models.Model):
    courier_ID = models.ManyToManyField(Courier)
    delivery_personnel_ID = models.ForeignKey(DeliveryPersonnel, on_delete=models.CASCADE)
    order_ID = models.ForeignKey(Checkout, on_delete=models.CASCADE)
    est_delivery_date = models.DateField()
    date_delivered = models.DateField(blank=True, null=True)
    delivery_status = models.IntegerField(default=0)


    def __str__(self):
        return f"{self.delivery_personnel_ID}"

