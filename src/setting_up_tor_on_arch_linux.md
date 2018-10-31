---
Author: Taha Azzaoui
Date: Mon Oct 29 17:07:42 EDT 2018
Title: Setting Up Tor On Arch Linux
---

# Intro
I'm assuming most know what Tor is, but for those who don't, Tor is basically a networking protocol that aids 
against traffic analysis attacks by bouncing your Internet requests through a network of relays (servers) 
around the globe. I won't go into how it works for now, the [Tor Project](https://torproject.org/about/overview.html.en)
covers it extensively. Let's look at setting it up on Arch.

# Systemd & The Tor Service

1. Start by installing `tor` and `torsocks`. The former is vanilla tor and the
   latter will let us "torify" an application
   
   > `sudo pacman -S tor torsocks`

2. For those in areas where Tor is blocked (China), we'll also install
   the obfuscation protocol `obfs4`. It's available in the AUR.
    
    > `yaourt -S obfs4proxy`

3. Now we need to get some bridges to use. Head over to [https://bridges.torproject.org/options](https://bridges.torproject.org/options)
   to acquire an `obfs4` bridge. You should end up with something like this: 

    > obfs4 \<IP\> \<Giberish\> cert=\<More Giberish\> iat-mode=0 <br>
    > obfs4 \<IP\> \<Giberish\> cert=\<More Giberish\> iat-mode=0 <br>
    > obfs4 \<IP\> \<Giberish\> cert=\<More Giberish\> iat-mode=0 <br>

4. Append the following into `/etc/tor/torrc`. Make sure to replace
   the bridges with the ones obtained above

    > UseBridges 1 <br>
    > # Substitute the following with the bridges you aquired from step 3 <br>
    > bridge obfs4 \<IP\> \<Giberish\> cert=\<More Giberish\> iat-mode=0 <br>
    > bridge obfs4 \<IP\> \<Giberish\> cert=\<More Giberish\> iat-mode=0 <br>
    > bridge obfs4 \<IP\> \<Giberish\> cert=\<More Giberish\> iat-mode=0 <br>
    > ClientTransportPlugin obfs4 exec /usr/bin/obfs4proxy managed <br>

5. Start the Tor service using `systemctl`

    > `sudo systemctl start tor.service` <br>
    
    To check if it worked, run 

    > `sudo systemctl status tor.service` <br>
   
    If all is well, you should see the following message

    > `Bootstrapped 100%: Done` <br>
   
    towards the end of the status message

6. Run applications with Tor
    
    Now that we have Tor working, we can run applications though it.
    To use Tor with an application you can use the ``torify`` command. For
    example, `torify bash` will bring up a bash shell running Tor. To verify, run

    > `torify bash` <br>
    > `curl ipinfo.io` <br>

    and you should see that the IP address shown is not your actual IP address.

# The GUI Route
Note that if you plan on using Tor for browsing the web, you can also install
`tor-browser` from the AUR which is essentially a hardened Firefox that comes
with Tor built in along with some useful addons like `noscript`.
