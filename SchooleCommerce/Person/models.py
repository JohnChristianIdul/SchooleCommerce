from django.db import models


# Create your models here.
class Person(models.Model):
    Type = [("M", "Merchant"),
            ("C", "Customer"),
            ("A", "School Admin"),
            ("D", "Delivery Personnel"),
            ("T", "Courier")]
    username = models.CharField(max_length=50, null=False)
    password = models.CharField(max_length=50, null=False)
    name = models.CharField(max_length=50, null=False)
    contact_number = models.CharField(max_length=50, null=False)
    email = models.CharField(max_length=50, null=False)
    address = models.CharField(max_length=50, null=False)
    person_type = models.CharField(max_length=1, choices=Type)

    class Meta:
        abstract = True
