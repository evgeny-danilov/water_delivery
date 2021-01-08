# Code design - make your life simpler

Technical task to show the way of building service objects by small iterations and without pre-defined structure.

## Task description
Let's imagine we develop an application which provide water delivery service. 

**Given an initial data structure of booked slots:**
```ruby
  [
    { date: '2020-12-07', time_period: '1', zone: 'A', address: 'street-10/7' },
    { date: '2020-12-07', time_period: '1', zone: 'A', address: 'street-23/3' },
    { date: '2020-12-07', time_period: '2', zone: 'A', address: 'street-1/6' },
    { date: '2020-12-07', time_period: '2', zone: 'A', address: 'street-1/57' },
    { date: '2020-12-07', time_period: '3', zone: 'A', address: 'street-5/7' },
  ]
```


**What needs to be done:**
Implement an isolated service which returns closest available slot for delivering.
Calculation depends on user request, namely, the desired date and time and the specific address.
There are maximum **two slots** per zone and date/time.
Zone could be found based on the input address 
(for example, if address started with `street`, it's zone A, otherwise it's zone B).

**Example of input data (user request):**
```ruby
  {
    date: '2020-12-07',
    address: 'street-10/7',
    time_period: '2'
  }
```

As we can see from initial data, there are no available slots for 2nd time period 
so that we suggest a next time period for delivering.

**Expected result from the service:**

```ruby
  { date: '2020-12-07', time_period: '3' }
```

## Links
 - Sandi Metz, Practical Object-Oriented Design (2nd edition): 
     https://www.amazon.com/gp/product/B07F88LY9M/ref=dbs_a_def_rwt_hsch_vapi_tkin_p1_i1
 - Sandi Metz, 99 Bottles of OOP: 
     https://sandimetz.com/99bottles
 - The Clean Code Blog by Robert C. Martin, Clean Architecture: 
     https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html