# Generated by Django 4.2.7 on 2023-12-28 22:55

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('Cart', '0015_alter_checkout_order_date_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='checkout',
            name='order_date',
            field=models.DateField(verbose_name=datetime.datetime(2023, 12, 29, 6, 55, 23, 328614)),
        ),
        migrations.AlterField(
            model_name='checkout',
            name='receive_by_date',
            field=models.DateField(default=datetime.datetime(2024, 1, 5, 6, 55, 23, 328614)),
        ),
    ]
