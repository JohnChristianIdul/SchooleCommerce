from django.db import models


# Create your models here.
class Customer(Person.Person):
    customer_ID = models.AutoField(primary_key=True, null=False)
    school_admin_ID = models.ForeignKey(SchoolAdmin.SchoolAdmin, on_delete=models.CASCADE)
    customer_wallet = models.FloatField(default=0.0)
    transaction_history = models.ForeignKey(Transaction.Transactions, on_delete=models.CASCADE)


class Report(models.Model):
    pass




