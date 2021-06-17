names = []
for _ in range(5):
    name = input("Please enter the name of someone you know. ")
    names.append(name)

lowercased = [name.lower() for name in names]
caps = [name.capitalize() for name in lowercased]
invitations = [
    f"Dear {name}, please come to the wedding this Saturday!" for name in caps]

for invitation in invitations:
    print(invitation)

# BONUS
# Create a thank you note to be addressed to all guests using
# f-string and print the statement using `title()` function.

ty_note = [
    f"Dear {name}, thanks for coming and celebrating with us!" for name in caps]
for note in ty_note:
    print(note.title())
