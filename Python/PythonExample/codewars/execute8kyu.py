from Kyu8 import TheWideMouthedFrog
from Kyu8 import GenerateRangeOfIntegers
from Kyu8 import FilterOutTheGeese

# TheWideMouthedFrog.mouth_size("test")


def execute8kyu(name: str) -> bool:
    print(f"NAME: {name}")
    name = name.lower()
    if name == "thewidemouthedfrog":
        c = TheWideMouthedFrog.TheWideMouthedFrog()
        return c.execute()
    elif name == "generaterangeofintegers":
        c = GenerateRangeOfIntegers.GenerateRangeOfIntegers()
        return c.execute()
    elif name == "filteroutthegeese":
        c = FilterOutTheGeese.FilterOutTheGeese()
        return c.execute()
    else:
        return False
