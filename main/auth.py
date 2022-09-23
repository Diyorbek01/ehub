import random
import string
import requests
import json

from django.contrib.auth import authenticate, login
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.authtoken.models import Token
from rest_framework.status import HTTP_404_NOT_FOUND

from main.models import User, UserToken


@api_view(['POST'])
def login(request):
    username = request.data["username"]
    password = request.data["password"]
    if User.objects.filter(username=username, password=password, is_superuser=True).exists():
        user = User.objects.get(username=username)
        token, created = Token.objects.get_or_create(user=user)
        data = dict(
            token=token.key,
        )
        return Response(data, status=200)
    else:
        return Response("User doesn't exist", status=400)



def send_sms(phone_number, code):
    url = "http://91.204.239.44/broker-api/send"

    payload = json.dumps({
        "messages": [
            {
                "recipient": phone_number,
                "message-id": "abc000000001",
                "sms": {
                    "originator": "3700",
                    "content": {
                        "text": f"Sizning tasdiqlash kodingiz: {code}"
                    }
                }
            }
        ]
    })
    headers = {
        'Authorization': 'Basic YXJjaGk6RlptNnU2NlQ4dg==',
        'Content-Type': 'application/json'
    }

    response = requests.request("POST", url, headers=headers, data=payload)

    return response.text


def random_string(digit_count):
    str1 = ''.join((random.choice(string.digits) for x in range(digit_count)))

    sam_list = list(str1)  # it converts the string to list.
    random.shuffle(sam_list)  # It uses a random.shuffle() function to shuffle the string.
    final_string = ''.join(sam_list)
    return final_string


@api_view(['POST'])
def chek_sms(request):
    code = request.data['code']
    token = UserToken.objects.all().last().token
    if code == token:
        return Response("Success", 200)
    else:
        return Response("Invalid sms code", 400)


@api_view(['POST'])
def register(request):
    code = request.data['code']
    data = UserToken.objects.all().last()
    token = data.token
    phone_number = data.phone_number
    if code == token:
        if User.objects.filter(phone_number=phone_number).exists():
            user_new = User.objects.get(phone_number=phone_number)
            user_new.is_user = True
            user_new.save()

            token, created = Token.objects.get_or_create(user=user_new)
            data.delete()

            data = {
                'token': token.key,
                "user": {
                    "user_id": user_new.id,
                    "first_name": token.user.first_name,
                    "last_name": token.user.last_name,
                    "phone_number": phone_number,
                }
            }
            return Response(data, status=200)
        else:
            user_new = User.objects.create(phone_number=phone_number)
            user_new.is_user = True
            user_new.save()
            token, _ = Token.objects.get_or_create(user=user_new)
            data.delete()
            data = {
                'token': token.key,
                "user": {
                    "user_id": user_new.id,
                    "phone_number": phone_number,
                }
            }
            return Response(data, 200)

    else:
        return Response('Invalid SMS code', status=400)


@api_view(['POST'])
def send_sms_register(request):
    phone_number = request.data['phone_number']
    code = random_string(4)
    result = send_sms(phone_number, code)
    data = UserToken.objects.create(
        token=code,
        phone_number=phone_number
    )
    return Response(result, 200)
