from django.db import models
from Person.models import Person


# Create your models here.
class SchoolAdmin(Person):
    school_admin = models.AutoField(primary_key=True, null=False)
    school_name = models.CharField(max_length=200, null=False)
    school_address = models.CharField(max_length=200, null=False)

    def __str__(self):
        return self.school_name


class ApproveMerchant(models.Model):
    pass
