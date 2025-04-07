# KODAQS_ASSIGNMENT_D2.1

Replication of Flamino et al. (2023): Ideological Polarization and Echo Chambers on Twitter During the 2016 and 2020 U.S. Presidential Elections

This repository contains materials for a computational reproduction of Flamino et al. (2023), who analyzed ideological polarization and echo chamber behaviors on Twitter during the 2016 and 2020 U.S. presidential elections. The original study utilized 873 million tweets, political bias classifications, and network analysis methods to document changes in the dissemination of biased content, polarization patterns, and influencer dynamics over time.

We successfully reproduced their findings and figures 1, 3, 4, 5, 6 using the analysis code and aggregated data provided in their OSF repository, with only minor deviations due to technical adjustments. However, the reproduction process revealed limitations in rehydrating the original dataset using Twitter/X's current API, underscoring significant challenges in replicating studies reliant on volatile platform data. See our report here (link to be added once the report is published).

This repository includes:

    Scripts and intermediary outputs from the original study
    Reproduction figures
    Code for a Twitter Rehydration (unsuccessful) attempt

Recommendations for interested reproducers

This repository is just for documentation of parts of our code changes during the reproduction and the figures we generated during our reproduction attempt. We want to refer the interested reproducer to the original OSF.io repository by Flamino et al. (https://osf.io/e395q/) which contains extensive details on how to reproduce their analysis. See here:

    Code repository: https://osf.io/dbzm2/
    Data repository: https://osf.io/e395q/

Please note that the original X/Twitter raw data cannot be shared for legal reasons so you cannot fully reproduce the entire analysis pipeline including data pre-processing etc. Their repository contains party of the original data as well as intermediary results.

The analysis was performed with Python version 3.12.3 and R version 4.3.3. For more information about the used packages see the file "package-list-python.txt" and "package-list-R.txt" respectively. Unfortunately, I cannot provide a 
