# Generated by Django 4.2.7 on 2023-12-28 22:54

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('Transaction', '0010_alter_transactions_transaction_date'),
    ]

    operations = [
        migrations.AlterField(
            model_name='transactions',
            name='transaction_date',
            field=models.DateField(default=datetime.datetime(2023, 12, 29, 6, 54, 55, 811804)),
        ),
    ]