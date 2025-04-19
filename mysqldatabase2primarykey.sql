--Create Database
--Create Job Table
CREATE TABLE Positions (
PositionID NUMBER PRIMARY KEY,
PositionTitle VARCHAR(64),
PositionDesc VARCHAR(255),
SalaryMin NUMBER,
SalaryMax NUMBER,
PositionCount NUMBER
);
INSERT INTO Positions VALUES('50105','Mill Operator','Operates the Crane and stacks the wood for transport','45000','65000','15');
INSERT INTO Positions VALUES('50106','Maintenance Technician ','Maintaines all equipement at various sites','35000','46000','7');
INSERT INTO Positions VALUES('50107','Site Manager','Manages a worksite and all its workers','75000','100000','12');
INSERT INTO Positions VALUES('50108','Dye Manager','Manages a mill and all its workers','75000','100000','15');
INSERT INTO Positions VALUES('50109','Press Manager','Manages the land parcels and their forests','55000','65000','2');
INSERT INTO Positions VALUES('50110','Equipment Specialist','Trains employees on equipment use and operates the equipment. ','30000','43000','16');
INSERT INTO Positions VALUES('50111','Shear Manager','Operate the cutting machines','20000','30000','38');
INSERT INTO Positions VALUES('50112','Dye Operator','Operate the transport equipment for moving products.','30000','45000','25');
INSERT INTO Positions VALUES('50113','Surveyor','Verify line boundaries for worksites','20000','30000','6');
INSERT INTO Positions VALUES('50114','Shear Operator','Verifies health of established Lines in the worksites','40000','55000','4');
INSERT INTO Positions VALUES('50115','Logistics Officer','Manages the transportation of the Conductors from worksites to mills','55000','65000','2');
INSERT INTO Positions VALUES('50116','Commercial Driver','Transports parts between worksites and lines.','45000','53000','20');
INSERT INTO Positions VALUES('50117','General Laborer','Entry level mill and site workers','15000','25000','87');
commit;

--Create ZipCode Table
CREATE TABLE Locations (
ZipCode VARCHAR(64) PRIMARY KEY,
City VARCHAR(64),
StateABBR VARCHAR(64)
);
INSERT INTO Locations VALUES('65536','Lebanon','MO');
INSERT INTO Locations VALUES('65578','Springfield','MO');
INSERT INTO Locations VALUES('65588','Boliver','MO');
INSERT INTO Locations VALUES('65576','Camdenton','MO');
INSERT INTO Locations VALUES('65537','Osage','MO');
INSERT INTO Locations VALUES('65598','Republic','MO');
INSERT INTO Locations VALUES('65534','St. Louis','MO');
INSERT INTO Locations VALUES('65579','Gascanade','MO');
INSERT INTO Locations VALUES('65531','Olive Branch','MO');
INSERT INTO Locations VALUES('65551','Rolla','MO');
commit;

--Create Product Table
CREATE TABLE Products (
ProductID NUMBER PRIMARY KEY,
ProductName VARCHAR(64),
ProductType VARCHAR(64),
ProductVolts NUMBER,
Conductor VARCHAR(64),
AVGHeight NUMBER,
AVGWidth NUMBER
);
INSERT INTO Products VALUES('4400100','Capacitor','Product','25','Y','3','2');
INSERT INTO Products VALUES('4400101','Resonator','Product','30','Y','4','2');
INSERT INTO Products VALUES('4400102','Transducers','Product','50','Y','7','2');
INSERT INTO Products VALUES('4400103','Switch','Product','20','Y','2','2');
INSERT INTO Products VALUES('4400104','Signal','Product','15','N','5','2');
INSERT INTO Products VALUES('4400105','SemiConductor','Product','25','Y','5','2');
INSERT INTO Products VALUES('4400106','Adapter','Component','20','Y','5','3');
INSERT INTO Products VALUES('4400107','DC Block','Component','15','Y','6','2');
INSERT INTO Products VALUES('4400108','Resistor','Component','20','N','6','2');
INSERT INTO Products VALUES('4400109','Buzzer','Component','15','N','5','6');
INSERT INTO Products VALUES('4400110','Control Nob','Component','20','N','6','2');
INSERT INTO Products VALUES('4400111','Fuse','Component','25','N','6','2');
commit;

--Create Orders Table
CREATE TABLE Orders (
OrderID NUMBER PRIMARY KEY,
OrderDate DATE,
OrderProcessingCost NUMBER,
OrderPickupDate DATE
);

INSERT INTO Orders VALUES('95002109758', to_date('11/6/2023','mm/dd/yyyy'),'50', to_date('11/8/2023','mm/dd/yyyy'));
INSERT INTO Orders VALUES('95002109759', to_date('11/6/2023','mm/dd/yyyy'),'25', to_date('11/8/2023','mm/dd/yyyy'));
INSERT INTO Orders VALUES('95002109760', to_date('11/6/2023','mm/dd/yyyy'),'20', to_date('11/8/2023','mm/dd/yyyy'));
INSERT INTO Orders VALUES('95002109761', to_date('11/5/2023','mm/dd/yyyy'),'15', to_date('11/7/2023','mm/dd/yyyy'));
INSERT INTO Orders VALUES('95002109762', to_date('11/5/2023','mm/dd/yyyy'),'30', to_date('11/7/2023','mm/dd/yyyy'));
INSERT INTO Orders VALUES('95002109763', to_date('11/1/2023','mm/dd/yyyy'),'35', to_date('11/3/2023','mm/dd/yyyy'));
INSERT INTO Orders VALUES('95002109764', to_date('11/1/2023','mm/dd/yyyy'),'15', to_date('11/3/2023','mm/dd/yyyy'));
INSERT INTO Orders VALUES('95002109765', to_date('11/2/2023','mm/dd/yyyy'),'25', to_date('11/4/2023','mm/dd/yyyy'));
INSERT INTO Orders VALUES('95002109766', to_date('11/2/2023','mm/dd/yyyy'),'18', to_date('11/4/2023','mm/dd/yyyy'));
INSERT INTO Orders VALUES('95002109767', to_date('11/4/2023','mm/dd/yyyy'),'60', to_date('11/6/2023','mm/dd/yyyy'));
INSERT INTO Orders VALUES('95002109768', to_date('11/3/2023','mm/dd/yyyy'),'45', to_date('11/5/2023','mm/dd/yyyy'));
INSERT INTO Orders VALUES('95002109769', to_date('10/31/2023','mm/dd/yyyy'),'25', to_date('11/2/2023','mm/dd/yyyy'));
commit;

--Create Utilities Table
CREATE TABLE Utilities (
UtilitiesID NUMBER PRIMARY KEY,
UtilitiesName VARCHAR(64),
UtilitiesAddress VARCHAR(64),
ZipCode VARCHAR(64),
UtilitiesPhone VARCHAR(64),
FOREIGN KEY (ZipCode) REFERENCES Locations(ZipCode)
);
INSERT INTO Utilities VALUES('303001','Mid-Valley Pipeline Co','79 Tallwood Ave.','65537','5648028483');
INSERT INTO Utilities VALUES('303002','AmeriGas Propane','45 Sulphur Springs Dr.','65536','4273944875');
INSERT INTO Utilities VALUES('303003','Chevron','654 Jefferson Street','65551','3864983481');
INSERT INTO Utilities VALUES('303004','Atmos Energy','9446 Summer Rd.','65531','9144799214');
INSERT INTO Utilities VALUES('303005','Laclede Electric','702 Berkshire Lane','65588','5778285576');
INSERT INTO Utilities VALUES('303006','GlobalSpec','8165 SW. Oklahoma Road','65537','3020327756');
INSERT INTO Utilities VALUES('303007','Growth Zone','87 1st Ave.','65598','2705252613');
INSERT INTO Utilities VALUES('303008','Choose Energy','187 Cedar Swamp Ave.','65579','9097480276');
INSERT INTO Utilities VALUES('303009','Walton Gas','210 Griffin St.','65576','8028887525');
INSERT INTO Utilities VALUES('303010','Constellation','7680 E. Fremont Rd.','65534','2607364085');
commit;

--Create Customer Table
CREATE TABLE Customers (
CustomerID NUMBER PRIMARY KEY,
CustomerFNAME VARCHAR(64),
CustomerLNAME VARCHAR(64),
CustomerEmail VARCHAR(64),
CustomerPhone VARCHAR(64),
CustomerADDRESS VARCHAR(64),
ZipCode VARCHAR(64),
Foreign Key (ZipCode) References Locations(ZipCode)

);
INSERT INTO Customers VALUES('101325415','Ashura','Perce','aperce@gmail.com','4663472041','563 Wild Rose Ave.','65551');
INSERT INTO Customers VALUES('101325416','Hershel','Nazanin','hnazanin@gmail.com','5582081779','301 Belmont Ave.','65531');
INSERT INTO Customers VALUES('101325417','Rigmor','Mia','RgiMia@gmail.com','6524946332','8162 West Halifax Dr.','65579');
INSERT INTO Customers VALUES('101325418','Adriana','Iuvenalis','aIuvenalis@Yahoo.com','8283350668','8448 South Sutor Lane','65534');
INSERT INTO Customers VALUES('101325419','Arevig','Bluma','aBlume@OutLook.com','2812731252','18 Livingston Lane','65598');
INSERT INTO Customers VALUES('101325420','Yianna','Pille','yPille@OutLook.com','2175128311','632 Edgefield Lane','65537');
INSERT INTO Customers VALUES('101325421','Sunan','Deianeira','Sunan.Deianira@gmail.com','2166042919','6 Glenholme Street','65537');
INSERT INTO Customers VALUES('101325422','Manuelita','Kirsi','Mkirsi@Yahoo.com','5074932925','8298 Fulton Ave.','65576');
INSERT INTO Customers VALUES('101325423','Olumide','Junayd','ojunayd@gmail.com','2220286353','8550 Edgefield St.','65576');
INSERT INTO Customers VALUES('101325424','Krishna','Brochmail','kBrochmail@gmail.com','2220286353','791 Leatherwood Circle','65588');
INSERT INTO Customers VALUES('101325425','Signý','Medrod','sMedrod@Yahoo.com','7722433570','3 Philmont Road','65578');
INSERT INTO Customers VALUES('101325426','Mihail','Navy','mNavy@google.com','4672140027','9544 West Birchwood Dr.','65536');
commit;

-- Create Invoice Table
CREATE TABLE Invoices (
InvoiceID NUMBER PRIMARY KEY,
CustomerID NUMBER,
OrderID NUMBER,
UtilitiesID NUMBER,
Foreign Key (CustomerID) References Customers(CustomerID),
Foreign Key (OrderID) References Orders(OrderID),
Foreign Key (UtilitiesID) References Utilities(UtilitiesID)

);
INSERT INTO Invoices VALUES('991009815095','101325422','95002109763','303006');
INSERT INTO Invoices VALUES('991009815096','101325418','95002109765','303005');
INSERT INTO Invoices VALUES('991009815097','101325417','95002109762','303008');
INSERT INTO Invoices VALUES('991009815098','101325419','95002109766','303001');
INSERT INTO Invoices VALUES('991009815099','101325420','95002109759','303009');
INSERT INTO Invoices VALUES('991009815100','101325422','95002109765','303007');
INSERT INTO Invoices VALUES('991009815101','101325416','95002109764','303008');
INSERT INTO Invoices VALUES('991009815102','101325425','95002109761','303005');
INSERT INTO Invoices VALUES('991009815103','101325415','95002109758','303002');
INSERT INTO Invoices VALUES('991009815104','101325422','95002109767','303005');
INSERT INTO Invoices VALUES('991009815105','101325423','95002109768','303006');
INSERT INTO Invoices VALUES('991009815106','101325421','95002109760','303001');
commit;

--Create Line Table
CREATE TABLE Lines (
LineID NUMBER PRIMARY KEY,
LineAddress VARCHAR(64),
ZipCode VARCHAR(64),
LineAcres NUMBER,
ProductID NUMBER,
Conductor VARCHAR(64),
FOREIGN KEY (ZipCode) REFERENCES Locations(ZipCode),
FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
INSERT INTO Lines VALUES('870050','379 Plymouth St.','65598','1000','4400104','N');
INSERT INTO Lines VALUES('870051','216 Miles St.','65534','200','4400108','N');
INSERT INTO Lines VALUES('870052','38 Harvard Court','65531','600','4400100','Y');
INSERT INTO Lines VALUES('870053','356 Sherwood Drive','65588','450','4400101','Y');
INSERT INTO Lines VALUES('870054','7870 Rockcrest St.','65536','155','4400104','N');
INSERT INTO Lines VALUES('870055','29 South High Point Rd.','65598','300','4400105','Y');
INSERT INTO Lines VALUES('870056','502 W. Locust Dr.','65551','300','4400111','N');
INSERT INTO Lines VALUES('870057','9513 Plymouth St.','65536','750','4400107','Y');
INSERT INTO Lines VALUES('870058','843 W. Devon St.','65578','620','4400101','Y');
INSERT INTO Lines VALUES('870059','43 53rd Lane','65531','190','4400110','N');
INSERT INTO Lines VALUES('870060','1 Hamilton St.','65534','605','4400109','N');
commit;

--Create Worksites Table
CREATE TABLE Worksites (
WorksiteID NUMBER PRIMARY KEY,
WorksiteLocation VARCHAR(64),
LineID NUMBER,
UtilitiesID NUMBER,
WorksiteManagerID NUMBER,
WorksiteManagerFname VARCHAR(64),
WorksiteManagerLname VARCHAR(64),
WorksiteManagerPhone VARCHAR(64),
Foreign Key (LineID) References Lines(LineID),
Foreign Key (UtilitiesID) References Utilities(UtilitiesID)
);
INSERT INTO Worksites VALUES('6025050','Lebanon','870053','303009','0107013','Jairus','Táhirih','4177569102');
INSERT INTO Worksites VALUES('6025051','Springfield','870050','303010','01107025','Yaron','Vikram','4178245189');
INSERT INTO Worksites VALUES('6025052','Boliver','870058','303005','01107022','Ehud','Richard','4178937123');
INSERT INTO Worksites VALUES('6025053','Camdenton','870051','303002','01107016','Euphemia','Xystos','4179076123');
INSERT INTO Worksites VALUES('6025054','Osage','870054','303005','01107023','Irén','Hiawatha','4177648298');
INSERT INTO Worksites VALUES('6025055','Republic','870056','303007','01107012','Kristen','Ibán','4171273912');
INSERT INTO Worksites VALUES('6025056','St. Louis','870060','303008','01107024','Rajabu','Mikhah','4174894318');
INSERT INTO Worksites VALUES('6025057','Gascanade','870057','303008','01107021','Rhouth','Luitger','4179083726');
INSERT INTO Worksites VALUES('6025058','Olive Branch','870055','303006','01107017','Llywellyn','Avril','4177683928');
INSERT INTO Worksites VALUES('6025059','Rolla','870052','303001','01107014','Alkippe','Lyanna','4179837265');
INSERT INTO Worksites VALUES('6025060','Lebanon','870059','303001','01107015','Joos','Melanthios','4170973629');
commit;

--Create Equipment Table
CREATE TABLE Equipment (
EquimentID NUMBER PRIMARY KEY,
EquipmentName VARCHAR(64),
EquipmentCondition VARCHAR(64),
EquipmentPurchaseDate DATE,
EquipmentPurchasePrice NUMBER,
WorksiteID NUMBER,
Foreign Key (WorksiteID) References Worksites(WorksiteID)
);
INSERT INTO Equipment VALUES('259100','Press Break','Excellent', to_date('10/10/2018','mm/dd/yyyy'),'56000','6025051');
INSERT INTO Equipment VALUES('259101','Centrifuge','Okay', to_date('5/15/2013','mm/dd/yyyy'),'30000','6025050');
INSERT INTO Equipment VALUES('259102','Mill','Okay', to_date('3/20/2008','mm/dd/yyyy'),'40000','6025054');
INSERT INTO Equipment VALUES('259103','Dye','Good', to_date('8/2/2011','mm/dd/yyyy'),'60000','6025051');
INSERT INTO Equipment VALUES('259104','Compressor','Great', to_date('1/4/2013','mm/dd/yyyy'),'57000','6025059');
INSERT INTO Equipment VALUES('259105','Press Break','Okay', to_date('5/4/2010','mm/dd/yyyy'),'80000','6025057');
INSERT INTO Equipment VALUES('259106','Welder','Excellent', to_date('12/12/2017','mm/dd/yyyy'),'67000','6025052');
INSERT INTO Equipment VALUES('259107','Turret','Okay', to_date('6/13/2013','mm/dd/yyyy'),'35000','6025055');
INSERT INTO Equipment VALUES('259108','Shear','Poor', to_date('7/17/2005','mm/dd/yyyy'),'48000','6025052');
INSERT INTO Equipment VALUES('259109','Decoil Line','Excellent', to_date('8/25/2017','mm/dd/yyyy'),'107000','6025054');
INSERT INTO Equipment VALUES('259110','CNC','Excellent', to_date('11/28/2017','mm/dd/yyyy'),'70500','6025059');
INSERT INTO Equipment VALUES('259111','Molder','Good', to_date('5/27/2015','mm/dd/yyyy'),'86000','6025053');
INSERT INTO Equipment VALUES('259112','Dye','Great', to_date('2/19/2010','mm/dd/yyyy'),'74000','6025052');
commit;

--Create Lease_Contracts Table
CREATE TABLE LeaseContracts (
LeaseContractID NUMBER PRIMARY KEY,
LineID NUMBER,
LeaseContractOwnerFname VARCHAR(64),
LeaseContractOwnerLname VARCHAR(64),
LeaseContractOwnerPhone VARCHAR(64),
LeaseContractContractDate DATE,
LeaseContractPrice NUMBER,
Foreign Key (LineID) References Lines(LineID)
);
INSERT INTO LeaseContracts VALUES('12300100','870056','Sam','Smith','6018259636', to_date('8/10/2018','mm/dd/yyyy'),'100000');
INSERT INTO LeaseContracts VALUES('12300101','870051','Marshall','Mathers','6015547898', to_date('6/13/2001','mm/dd/yyyy'),'150000');
INSERT INTO LeaseContracts VALUES('12300102','870055','Sam','Smith','6018259636', to_date('6/9/2017','mm/dd/yyyy'),'300000');
INSERT INTO LeaseContracts VALUES('12300103','870057','Ed','Sheeren','6625556699', to_date('9/25/2000','mm/dd/yyyy'),'500000');
INSERT INTO LeaseContracts VALUES('12300104','870050','Alan','Jackson','6621123355', to_date('5/31/2015','mm/dd/yyyy'),'1000000');
INSERT INTO LeaseContracts VALUES('12300105','870054','Kenny','Chesney','6628811000', to_date('10/25/2013','mm/dd/yyyy'),'540000');
INSERT INTO LeaseContracts VALUES('12300106','870058','Jason','Carroll','6628584123', to_date('1/14/2013','mm/dd/yyyy'),'350000');
INSERT INTO LeaseContracts VALUES('12300107','870059','Brantley','Gilbert','6624490028', to_date('7/15/2013','mm/dd/yyyy'),'625000');
INSERT INTO LeaseContracts VALUES('12300108','870053','Brooks','Dunn','6629962228', to_date('9/26/2016','mm/dd/yyyy'),'225000');
INSERT INTO LeaseContracts VALUES('12300109','870060','Luke','Combs','6624112986', to_date('8/12/2011','mm/dd/yyyy'),'152000');
INSERT INTO LeaseContracts VALUES('12300110','870052','Oliver','Sykes','6625132699', to_date('6/15/2009','mm/dd/yyyy'),'195000');
commit;

--Create Employee Table
CREATE TABLE Employees (
EmployeeID NUMBER PRIMARY KEY,
EmployeeFname VARCHAR(64),
EmployeeMinit VARCHAR(64),
EmployeeLname VARCHAR(64),
EmployeeSsn NUMBER,
EmployeeAddress VARCHAR(64),
ZipCode VARCHAR(64),
EmployeePhone VARCHAR(64),
EmployeeSalary NUMBER,
WorksiteID NUMBER,
PositionID NUMBER,
FOREIGN KEY (ZipCode) REFERENCES Locations(ZipCode),
FOREIGN KEY (WorksiteID) REFERENCES Worksites(WorksiteID),
FOREIGN KEY (PositionID) REFERENCES Positions(PositionID)
);
INSERT INTO Employees VALUES('01107010','Tonina','J','Natacha','134825433','379 Plymouth St.','65598','4177463736','25000','6025059','50111');
INSERT INTO Employees VALUES('01107011','Jernej','A','Devraj','837948171','216 Miles St.','65534','4178972356','55000','6025051','50114');
INSERT INTO Employees VALUES('01107012','Kristen','L','Ibán','570691690','38 Harvard Court','65588','4171273912','78000','6025055','50106');
INSERT INTO Employees VALUES('01107013','Jairus','V','Táhirih','463236020','356 Sherwood Drive','65588','4177569102','100000','6025050','50117');
INSERT INTO Employees VALUES('01107014','Alkippe','P','Lyanna','830255464','7870 Rockcrest St.','65536','4179837265','83000','6025059','50106');
INSERT INTO Employees VALUES('01107015','Joos','D','Melanthios','752842685','29 South High Point Rd.','65598','4170973629','86000','6025060','50107');
INSERT INTO Employees VALUES('01107016','Euphemia','A','Xystos','369632542','502 W. Locust Dr.','65551','4179076123','100000','6025053','50108');
INSERT INTO Employees VALUES('01107017','Llywellyn','M','Avril','802518003','9513 Plymouth St.','65578','4177683928','75000','6025058','50116');
INSERT INTO Employees VALUES('01107018','Elizabeth','R','Lamija','464390098','843 W. Devon St.','65578','4179082712','24000','6025057','50117');
INSERT INTO Employees VALUES('01107019','Honor','N','Lennart','139252371','43 53rd Lane','65531','4170936099','45000','6025059','50112');
INSERT INTO Employees VALUES('01107020','Anneli','H','Matilde','496267768','1 Hamilton St.','65534','4178478822','25000','6025060','50113');
INSERT INTO Employees VALUES('01107021','Rhouth','B','Luitger','119538634','6 South Bellevue Lane','65579','4179083726','78000','6025057','50107');
INSERT INTO Employees VALUES('01107022','Ehud','P','Richard','845544217','109 West Smith Ave.','65536','4178937123','83000','6025052','50117');
INSERT INTO Employees VALUES('01107023','Irén','E','Hiawatha','544213650','312 W. Olive Drive','65534','4177648298','80000','6025054','50108');
INSERT INTO Employees VALUES('01107024','Rajabu','S','Mikhah','533717390','8094 Cleveland Drive','65551','4174894318','96000','6025056','50116');
INSERT INTO Employees VALUES('01107025','Yaron','O','Vikram','783561661','43 Pin Oak Drive','65588','4178245189','76000','6025051','50105');
INSERT INTO Employees VALUES('01107026','Akosua','A','Rosa','633680502','8095 Spring St.','65537','4178134831','63000','6025055','50109');
INSERT INTO Employees VALUES('01107027','Esthiru','A','Kishori','736564524','9210 Smith Lane','65578','4177551456','43000','6025058','50110');
INSERT INTO Employees VALUES('01107028','Anuki','D','Lysandra','337022764','8304 West Lakeview St.','65536','4171257854','30000','6025055','50111');
INSERT INTO Employees VALUES('01107029','Hermenegildo','J','Maria','761031319','7 Homestead Street','65598','4178413674','52000','6025054','50105');
INSERT INTO Employees VALUES('01107030','Abigaia','A','Eudokia','113177762','326 Mayfield Circle','65534','4171883648','30000','6025052','50113');
INSERT INTO Employees VALUES('01107031','Pāvels','A','Aled','457653079','9070 Willow Drive','65579','4178411564','35000','6025056','50117');
INSERT INTO Employees VALUES('01107032','Robert','D','Yukonichski','284930816','1221 West Palm Drive','65598','4177658997','45000','6025050','50109');
INSERT INTO Employees VALUES('01107033','Daniel','W','Zunuri','108340788','2258 Bullet Road','65531','4657890110','58000','6025053','50114');
INSERT INTO Employees VALUES('01107034','Baxton','X','Allred','112274689','798 Old Taylor','65537','4178992351','38000','6025056','50112');
INSERT INTO Employees VALUES('01107035','Ulri','W','Lobbertwishki','457653079','9070 Willow Drive','65579','4178411564','25000','6025056','50116');
commit;
