# Generated by Django 4.2.7 on 2023-12-28 17:43

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('Customer', '0001_initial'),
        ('Transaction', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='customer',
            name='transaction_history',
            field=models.ManyToManyField(related_name='customer_history', to='Transaction.transactions'),
        ),
    ]
