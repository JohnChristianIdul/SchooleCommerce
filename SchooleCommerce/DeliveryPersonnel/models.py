from django.db import models
from Person.models import Person
from Cart.models import Order


# Create your models here.
class DeliveryPersonnel(Person):
    delivery_personnel_ID = models.BigAutoField(primary_key=True)
    order = models.ManyToManyField(Order)
    choices = [("Out for Delivery", "Out for Delivery"),
               ("Attempt Delivery", "Attempt Delivery"),
               ("Failed Delivery", "Failed Delivery"),
               ("Returned", "Returned"),
               ("Delayed", "Delayed"),
               ("Delivered", "Delivered")]
    delivery_status = models.CharField(max_length=30, choices=choices)

    def __str__(self):
        return f"{self.delivery_personnel_id}"


class Courier(models.Model):
    courier_ID = models.BigAutoField(primary_key=True)
    delivery_personnel = models.ForeignKey(DeliveryPersonnel, on_delete=models.CASCADE)
    order = models.ForeignKey(Order, on_delete=models.CASCADE)
    delivery_date = models.DateField()
    commission = models.FloatField(default=500.0)

    def __str__(self):
        return f"{self.courier_ID}"

