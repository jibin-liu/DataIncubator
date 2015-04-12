### Housing New York
[Housing New York] (http://www.nyc.gov/html/housing/assets/downloads/pdf/housing_plan.pdf) is a five-borough, ten-year strategy to address the City’s affordable housing crisis. Over 13 city agencies and 200 individual stakeholders help to coordinate this plan, to building or preserving 200,000 units of high-quality affordable housing for more than 500,000 people.

### 1. Summary
In this proposed study, the potential affordable housing units and their distribution was analyzed. The distribution of commercial-residential mix-use district and low/medium/high density residential district was studied, to support future urban planning and suburban development. Specifically, the potential affordable housing units were generated and calculated based on available residential-use vacant land. Most of the potential residential units in Brooklyn and Bronx were in medium-density residence districts, while in Queens and Staten Island were in lowerdensity residence districts. The distribution of these potential residential units can be integrated with public transportation, census, and other data to help with affordable housing
development in NYC.

### 2. Data
The data used in this study was the PLUTO (14v2) data from NYC Department of City Planning (DCP). Meanwhile, Floor-Area-Ratio(FAR) and residential density data was from DCP's *Zoning Handbook (2011 Edition) and Zoning Resolution (2011 Edition)*. All the data are available within this repo.

Zoning districts with landuse categoried as "Vacant land (V)", specifically under "V0"/"V3"/"V9" were selected as potential places for building affordable housing. 

The maximum number of residential units allowed in a specific zoning districts was determined by the maximum permitted floor area dived by the residential density factor. Moreover, it is regulated in Zoning Resolution that fractions equal to or greater than 0.75 can be rounded up. Thus the number of potential residential units were calculated as:

*Potential Residential Units = Lot Area x FAR / Residential Density*

The calculated number of units were stored under “UnitNumber” field in PLUTO dataset.

### 3. Explotary Analysis Results


### 4. Limitations
In this study, only the vacant land inventory was included. However, there also manufacturing districts and other publicly controlled sites such as municipal parking lots, cleaned brownfields, obsolete buildings, and NYCHA housings can be included as underdeveloped land. The addition of other underdeveloped land can increase the total lot areas for affordable housing, and also gives more opportunities to build mixed residential and commercial communities.

### 5. Futher studies
Public requests and social media data can be collected and aggregated by blocks or census tracts to determine the neighborhood with more affordable housing requests. Meanwhile, census income data can also be incorporated in the analysis to help define whether a specific area is suitable for residential or commercial development. In the end, public transportation distribution can help to determine low-, medium-, and higher-density residential development.

### References
*Zoning Handbook*, 2011 Edition, New York City Department of City Planning, **2011**
*Zoning Resolution*, 2011 Edition, New York City Department of City Planning, **2011**
