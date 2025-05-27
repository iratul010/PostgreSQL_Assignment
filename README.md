# PostgreSQL_Assignment

 ## 1. What is PostgreSQL?

**PostgreSQL** হচ্ছে একটি **ওপেন-সোর্স, রিলেশনাল ডাটাবেস ম্যানেজমেন্ট সিস্টেম (RDBMS)**। এর মাধ্যমে আপনি ডেটা **সংরক্ষণ**, **খুঁজে বের**, **আপডেট** এবং **মুছে ফেলা** সহ নানা কাজ করতে পারেন।

এটি অনেকটা Excel-এর মত টেবিল আকারে ডেটা সংরক্ষণ করে, তবে অনেক বেশি **শক্তিশালী, নিরাপদ**, এবং বড় বড় প্রজেক্টে ব্যবহারের জন্য উপযোগী। PostgreSQL প্রোগ্রাম বা ওয়েব অ্যাপ্লিকেশনের সাথে সংযুক্ত হয়ে ডেটা পরিচালনা করে।

 **Key Features:**
- Open-source and free to use
- Supports complex queries, joins, indexing, and triggers
- Strong support for ACID compliance
- Extensible with custom data types, operators, and functions

 **Example Use Case:**

একটি ওয়েবসাইটে ইউজারদের নাম, ইমেইল, পাসওয়ার্ড ইত্যাদি সংরক্ষণ করতে PostgreSQL ব্যবহার করা হয়। নিচে একটি সাধারণ ইউজার টেবিলের উদাহরণ:

```sql
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  password TEXT
);


##  2. What is the Purpose of a Database Schema in PostgreSQL?

**PostgreSQL**-এ একটি **Schema** হলো ডাটাবেসের ভিতরের একটি ফোল্ডারের মতো, যেখানে **টেবিল (tables)**, **ভিউ (views)**, **ফাংশন (functions)**, **ইন্ডেক্স (indexes)** ইত্যাদি সংরক্ষণ করা হয়। এটি ডাটাবেসকে আরও **গুছিয়ে এবং নিরাপদভাবে** ব্যবস্থাপনা করতে সাহায্য করে।

 

###  কেন Schema ব্যবহার করা হয়?

- ✅ **লজিক্যাল গ্রুপিং:** একসাথে সম্পর্কিত ডেটাগুলো একই স্কিমায় রাখা যায়, যেমন: `users`, `orders`, `products`।
- ✅ **নেম কনফ্লিক্ট এড়ানো:** একাধিক স্কিমায় একই নামের টেবিল রাখা গেলেও তারা আলাদা থাকবে।
- ✅ **পারমিশন কন্ট্রোল:** প্রতিটি স্কিমার জন্য আলাদা পারমিশন সেট করা যায় — নিরাপত্তার জন্য গুরুত্বপূর্ণ।
- ✅ **মাল্টি-টেন্যান্স সাপোর্ট:** ভিন্ন ভিন্ন ক্লায়েন্ট বা ইউজারের ডেটা আলাদা স্কিমায় রেখে আইসোলেশন নিশ্চিত করা যায়।
 

###  উদাহরণ:

```sql
-- দুইটি আলাদা Schema তৈরি করা হলো
CREATE SCHEMA public;
CREATE SCHEMA admin;

-- public স্কিমায় users টেবিল
CREATE TABLE public.users (
  id SERIAL PRIMARY KEY,
  name TEXT
);

-- admin স্কিমায় settings টেবিল
CREATE TABLE admin.settings (
  id SERIAL PRIMARY KEY,
  config_key TEXT,
  config_value TEXT
);


## 3. Explain the Primary Key and Foreign Key concepts in PostgreSQL.?

###  Primary Key 

**Primary Key** হলো এমন একটি কলাম বা কলামের সেট যেটি একটি টেবিলের প্রতিটি রেকর্ডকে **অন্য রেকর্ড থেকে ইউনিকভাবে আলাদা করে**।

#### বৈশিষ্ট্য:
- প্রতিটি রেকর্ডে **একটি ইউনিক ভ্যালু** থাকে  
- কখনোই **NULL** হতে পারে না  
- সাধারণত এটি `id` ফিল্ডে ব্যবহৃত হয়  

**উদাহরণ:**

```sql
CREATE TABLE customers (
  customer_id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT UNIQUE
);

###  Foreign Key  

**Foreign Key** হলো এমন একটি কলাম যা অন্য একটি টেবিলের Primary Key-এর সাথে সম্পর্ক তৈরি করে।

####  কাজ:
- দুটি টেবিলের মধ্যে **রিলেশন** তৈরি করে  
- **ডেটা ইন্টিগ্রিটি** নিশ্চিত করে (যেমন: invalid ID ইনপুট হতে বাধা দেয়)

####  উদাহরণ:

```sql
CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY,
  order_date DATE,
  customer_id INTEGER,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


## 4. What is the difference between the VARCHAR and CHAR data types?

PostgreSQL-এ `VARCHAR` এবং `CHAR` — দুটোই **স্ট্রিং ডেটা টাইপ**, অর্থাৎ টেক্সট রাখার জন্য ব্যবহার হয়। তবে এদের মধ্যে কিছু পার্থক্য আছে 

###  `CHAR(n)` (Fixed Length Character)
- এটি **ফিক্সড লেন্থ** টাইপ।
- আপনি যদি `CHAR(10)` দেন এবং "Hi Ratul" লিখেন, তাহলে বাকি 2টি জায়গায় **স্পেস** দিয়ে পূরণ করে।
- জায়গা নষ্ট হয়, তবে পারফরম্যান্স নির্দিষ্ট ক্ষেত্রে ভালো হতে পারে।

 উদাহরণ:
```sql
CREATE TABLE example_char (
  code CHAR(5)
);
-- 'AB' ইনসার্ট করলে, ভেতরে রাখা হবে 'AB   '
## 5. Explain the purpose of the WHERE clause in a SELECT statement

`WHERE` ক্লজ হলো SQL এর একটি গুরুত্বপূর্ণ অংশ, যা `SELECT` স্টেটমেন্টে **ডেটা ফিল্টার করার জন্য** ব্যবহার করা হয়।

### উদ্দেশ্য:

- ডাটাবেজ থেকে **নির্দিষ্ট শর্ত পূরণ করা রেকর্ডগুলোই খুঁজে বের করতে** WHERE ক্লজ ব্যবহার করা হয়।
- অর্থাৎ, আপনি পুরো টেবিল থেকে নয়, শুধুমাত্র যেসব রেকর্ড আপনার শর্তের সাথে মিলবে সেগুলোই দেখতে পারবেন।

### উদাহরণ:

```sql
SELECT * FROM customers WHERE city = 'Dhaka';
