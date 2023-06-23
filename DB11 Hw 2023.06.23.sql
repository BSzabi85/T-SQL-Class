use AdventureWorks2012;
Go

Select
Pp.FirstName,
Pp.MiddleName,
Pp.LastName,
PaT.Name AddressType,
Pc.Name Country ,
Pa.AddressLine1,
Pa.AddressLine2,
Pa.City,
Pa.PostalCode,
PPhT.Name PhoneNumberType,
PPh.PhoneNumber
From Person.Person Pp
Join Person.BusinessEntityAddress Pba
on Pp.BusinessEntityID = Pba.BusinessEntityID
Join Person.Address Pa
on Pba.AddressID = Pa.AddressID
Join Person.AddressType PaT
on Pba.AddressTypeID = PaT.AddressTypeID
Join Person.PersonPhone PPh
on Pp.BusinessEntityID = PPh.BusinessEntityID
Join Person.PhoneNumberType PPhT
on PPh.PhoneNumberTypeID = PPhT.PhoneNumberTypeID
Join Person.StateProvince PsP
on Pa.StateProvinceID = PsP.StateProvinceID
Join Person.CountryRegion Pc
on Pc.CountryRegionCode = PsP.CountryRegionCode
Order by Pp.FirstName, Pp.LastName;