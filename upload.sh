tar cvzf index.tar.gz Infertility/ index.html
scp -r -i shinytest.pem index.tar.gz  'ubuntu@ec2-54-172-97-29.compute-1.amazonaws.com:/home/ubuntu'

ssh -vi shinytest.pem 'ubuntu@ec2-54-172-97-29.compute-1.amazonaws.com' bash -c "'
sudo mv index.tar.gz /srv/shiny-server/
cd /srv/shiny-server
sudo tar -xvzf index.tar.gz
sudo chown shiny:shiny .
sudo chown -R shiny:shiny .
exit
'"