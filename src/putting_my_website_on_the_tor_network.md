---
author: Taha Azzaoui
date: 2019-01-22
title: Putting My Website on The Tor Network
categories:
    - web
    - privacy
---

![](/images/tornet-diag.jpg)

# Introduction

I've gone over setting up [tor](https://www.torproject.org/) 
as a client to be able to access hidden services in the past
[here](https://azzaoui.org/blog/setting_up_tor_on_arch_linux.html).
This time, I thought it would be cool to host a hidden service on the Tor network.
Note that while the point of hidden services is to publish sites without revealing one's identity,
I'll just be serving this site here, so I'm not too concerned with anonymity. 

# TL;DR on Tor 

Tor is well known for being a network that allows one to browse the web with some level of anonymity. 
It does so by nesting layers of encryption and routing packets through nodes in the network such that
each node has only enough information to decipher which node the packet came from and which node to forward it to.
As such, a packet's path through the Tor network cannot be deterministically traced. 
For more on how this works see [here](https://www.torproject.org/about/overview).

# Setting Up the Hidden Service

1. Start by installing tor (obviously). It should be available via your local
   package manager.

   `$ sudo apt install tor`

2. Next, edit the configuration file
    
    `$ sudo vim /etc/tor/torrc`
   
    Uncomment the line that reads

    `RunAsDaemon 1`

    as well as the line that reads 

    `DataDirectory /var/lib/tor`
    
    Jump down to the section labeled

    `############### This section is just for location-hidden services ###`

    Uncomment the two lines 

    ```
     HiddenServiceDir /var/lib/tor/hidden_service/
     HiddenServicePort 80 127.0.0.1:80
    ```

3. Start the tor daemon
    
    ```
    $ sudo systemctl start tor
    $ sudo systemctl enable tor
    ```
    
    To see your generated .onion address, run 
    
    `$ sudo cat /var/lib/tor/hidden_service/hostname`

4. Edit your web server configuration. I'm using Apache in this case. Locate the
   site configuration in use, found in `/etc/apache2/sites-available/` and add
   the line
   
   `ServerAlias <your generated address>.onion`
   
   directly under where the ServerName is specified.

   Finally, restart Apache

   `$ sudo systemctl restart apache2`

Your hidden service should now be live. Check out using a Tor browser. 
