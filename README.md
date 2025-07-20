# Taxator
This was developed as a valid gem, but the easiest/fastest way to check it out
is to clone the repo and execute:

    $ ./exe/taxator FILE_PATH

Where `<FILE_PATH>` is the path for a purchase file in the specified as specified.
To make it easier to test this, one can use the fixtures provided in
`spec/fixtures`. Like so:

    $ ./exe/taxator spec/fixtures/input1
    $ ./exe/taxator spec/fixtures/input2
    $ ./exe/taxator spec/fixtures/input3

## Architectural choices
The `Purchase` type represents one single purchase and is formed by a
collection of items. Those are given by the "purchase file" format specified in
the challenge.

A `Reader` is responsible for extraction of those items from files. While the
formatters (for this exercise only the `CLI` was implemented) can output the
`Purchase` in a given, well... format.

There is a `Taxes` class used to isolate the decision of what taxes to apply and
also the ideas behind how to calculate those taxes. To allow for easy extension
of this logic, the actual "modality" of tax is implemented under a simple
interface (`#applicable?` and `#call`) under the `Modalities` model.


## Assumptions

- input file is considered correct and wellformed:
    - amount, item name and prices are not checked for typing or format

## Usage

    $ ./exe/taxator FILE_PATH
