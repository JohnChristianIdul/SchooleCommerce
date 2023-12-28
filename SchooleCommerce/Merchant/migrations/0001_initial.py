# Generated by Django 4.2.7 on 2023-12-28 17:43

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Merchant',
            fields=[
                ('username', models.CharField(max_length=50)),
                ('password', models.CharField(max_length=50)),
                ('name', models.CharField(max_length=50)),
                ('contact_number', models.CharField(max_length=50)),
                ('email', models.CharField(max_length=50)),
                ('address', models.CharField(max_length=50)),
                ('merchant_ID', models.BigAutoField(primary_key=True, serialize=False)),
                ('store_name', models.CharField(max_length=200)),
                ('verification_status', models.BooleanField(default=False)),
                ('merchant_wallet', models.FloatField(default=0)),
                ('person_type', models.CharField(default='M', max_length=1)),
            ],
            options={
                'abstract': False,
            },
        ),
    ]