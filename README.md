# Llangattock Place Plan Statistics

This repo has code to preprocess 2011 and 2021 census data to provide baseline statistics for the [Llangattock Place Plan](https://www.llangattock-cc.gov.wales/llangattock-place-plan/).

You can see the resulting visualizations at https://observablehq.com/d/3c2ed6db5f9670b4.

## Resources

- Homepage: https://www.llangattock-cc.gov.wales/llangattock-place-plan/
- A plan for Llangattock: Creating a Place Plan for our community, Llangattock Place Plan Steering Group, May 2023 (PDF)

## Changes between 2011 and 2021 using census data

Useful list of datasets: https://www.nomisweb.co.uk/sources/census_2021_bulk
But note these do _not_ include data for Llangattock (not sure why).

## Datasets

### Number of usual residents

- Dataset ID: TS001
- Area type: Output Areas

https://www.ons.gov.uk/datasets/TS001/editions/2021/versions/3/filter-outputs/c9197199-1caf-4495-af75-808ef4d02128#get-data

### Age by five-year age bands

Note that we use five-year bands, not single year as the latter is not available at OA level.

- Dataset ID: TS007A
- Area type: Output Areas

Download from https://www.nomisweb.co.uk/sources/census_2021_bulk

2011

https://www.nomisweb.co.uk/census/2011/ks102ew

### Household size

- Dataset ID: TS017
- Area type: Output Areas

2011

Household composition doesn't have a breakdown by number of people
https://www.nomisweb.co.uk/census/2011/ks105ew

It does have number of one-person households, so we can pull that out for comparison.

### Total number of households

- Dataset ID: TS041
- Area type: Output Areas

https://www.ons.gov.uk/datasets/TS041/editions/2021/versions/3/filter-outputs/9423ea0d-d9a9-4237-a148-85827d56c1a9#get-data

2011

Household spaces - also includes number of households with no usual residents

https://www.nomisweb.co.uk/census/2011/qs417ew

### Accommodation type

- Dataset ID: TS044
- Area type: Output Areas

https://www.ons.gov.uk/datasets/TS044/editions/2021/versions/4/filter-outputs/f0f1d5e2-49f3-4ada-bbaf-77b45fa8da1b#get-data

2011

Doesn't compare easily with 2021, so haven't included.

### Number of bedrooms

2021 Census data

- Dataset ID: TS050
- Area type: Output Areas

https://www.ons.gov.uk/datasets/TS050/editions/2021/versions/4/filter-outputs/1402de62-4514-49d6-8587-7e0e67337dbc#get-data

2011 Census data

https://www.nomisweb.co.uk/census/2011/ks404ew

This only has the average number of bedrooms, not a breakdown by each number.

### Tenure

2021 Census data

- Dataset ID: TS054
- Area type: Output Areas

https://www.ons.gov.uk/datasets/TS054/editions/2021/versions/4/filter-outputs/07a70786-e857-47ed-804a-ad3970a5646c#get-data

2011 Census data

https://www.nomisweb.co.uk/census/2011/ks402ew

### Car and van availability

2021 Census data

- Dataset ID: TS045
- Area type: Output Areas

https://www.ons.gov.uk/datasets/TS045/editions/2021/versions/4/filter-outputs/22828998-7942-46a8-a0d0-b091e1bada8f#get-data

Note that this data was _not_ found at:

- https://www.nomisweb.co.uk/sources/census_2021_bulk - missing Llangattock

2011 Census data

https://www.nomisweb.co.uk/census/2011/ks404ew

### Economic activity status

- Dataset ID: TS066
- Area type: Output Areas

https://www.ons.gov.uk/datasets/TS066/editions/2021/versions/5/filter-outputs/1216c754-c87e-4c24-b20b-14376de778d6#get-data

2011

https://www.nomisweb.co.uk/census/2011/qs601ew

## House Prices

HPSSA dataset 36 Number of sales of residential properties for wards
HPSSA dataset 37 Median price paid for wards
HPSSA dataset 38 Mean price paid for wards
HPSSA dataset 39 Lower quartile price paid for wards
HPSSA dataset 40 Tenth percentile price paid for wards
