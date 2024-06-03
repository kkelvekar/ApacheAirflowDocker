# from cryptography.fernet import Fernet
# key = Fernet.generate_key()
# print(key.decode())


import os
secret_key = os.urandom(24)
print(secret_key.hex())


