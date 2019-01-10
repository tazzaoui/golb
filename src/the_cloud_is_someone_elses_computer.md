---
Author: Taha Azzaoui
Date: Mon Oct 29 10:43:45 EDT 2018
Title: The cloud is just someone else's computer
---

# Intro 
Nowadays storing your data in the "cloud" for the sake of accessibility and
overall convenience is pretty much the norm. It's almost impossible to purchase
any sort of mobile device without also getting some type of remote storage
option along with it. Personally, it goes without saying that storing your
personal data on some company's servers is less than ideal for two reasons. 

# Privacy
First, there's the obvious privacy concern. It's impossible to be certain of
the privacy of your information since cloud storage providers rarely make
available the means with which they handle your data. Furthermore, even when
providers do make claims about the soundness of their protocols, using
buzzwords like "end to end encryption", it's usually infeasible to verify
these claims. Some providers, however are upfront about their privacy violations.
Take for example this paragraph out of Goolag's terms of service:

> "*When you upload or otherwise submit content to our Services, you give Google
> (and those we work with) a worldwide license to use, host, store, reproduce,
> modify, create derivative works (such as those resulting from translations,
> adaptations or other changes we make so that your content works better with our
> Services), communicate, publish, publicly perform, publicly display and
> distribute such content. The rights you grant in this license are for the
> limited purpose of operating, promoting, and improving our Services, and to
> develop new ones.*"

Now, of course no one reads these things, but it should come as no surprise that
any data you upload to Goolag's servers is heavily scrutinized.

# Control
The second reason for not relying on others to store your data is for overall
control. In adopting the services of a provider, you lose the ability to
interact with your raw data, and instead have to resort to using bloated web
apps or undocumented APIs provided by the service. Now, this is probably not a big deal for
those who use the "cloud" simply for storing things and rarely for performing any
complex operations. However, this is clearly a problem for those who need the ability to perform
nontrivial tasks, or to efficiently manage their data. Additionally, many of the
choices one can make about how to store their information are left for the
provider to make. Choices like what type of drives to use, what file system to
use them with, which encryption algorithm to use, what level of redundancy is
required, etc. These choices are highly user specific and while providers try to
optimize their decisions for the average user, those in need of the performance boost tend
to miss out.

# Solving the Convenience Problem
To solve this problem, I picked up four 1TB drives along with a Raspberry Pi for network access. 
I set up [Nextcloud](https://nextcloud.com), an open source self-hosted cloud software package, 
on the Pi with one of the drives. This solved the convenience problem, as Nextcloud lets me 
sync my calendar, contacts, notes, and photos automatically between my phone, laptop, and the Pi.
Nextcloud also works with full-disk encryption, so no problems there either. I
then set up port forwarding with the Pi along with openssl and strict https enforcement to make it
so that I can log in securely from outside of my home network.

# Status and Future Works
I still haven't decided what do with the rest of the drives. I currently use one of
them to backup my machine, and keep another one mounted via sshfs for keeping things 
I want to be able to access locally on my home network. So far, this setup works 
quite well, but I'm always open to opportunities for increasing efficiency.
