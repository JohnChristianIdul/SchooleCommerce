# Generated by Django 4.2.5 on 2023-10-09 07:38

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='ApproveMerchant',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
            ],
        ),
        migrations.CreateModel(
            name='SchoolAdmin',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=50)),
                ('email', models.CharField(max_length=50)),
                ('contact_number', models.CharField(max_length=50)),
                ('address', models.CharField(max_length=50)),
                ('username', models.CharField(max_length=50)),
                ('password', models.CharField(max_length=50)),
                ('person_type', models.CharField(choices=[('M', 'Merchant'), ('C', 'Customer'), ('A', 'School Admin')], max_length=1)),
            ],
            options={
                'abstract': False,
            },
        ),
    ]