#!/bin/bash
./terraform apply \
    -var 'tenant_id=0a75ec92-a05e-4a6f-ab2a-674c66a5e2ab' \
    -var 'subscription_id=eb5221ea-7039-446e-b354-fbaf27f4583a' \
    -var 'client_id=7e65e0c9-3866-41ad-84d2-cecde9376b8d' \
    -var 'client_secret=e62be7a5-0b33-48fa-a350-1638fae04a91' \
    ./terraform_scripts