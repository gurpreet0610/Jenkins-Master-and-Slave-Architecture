STR=$(kubectl get all)
SUB='web-deployment'
if [[ "$STR" == *"$SUB"* ]];
then
echo "Updating............";
kubectl set image  deploy web-deployment web-deployment-container=gurpreets0610/test-website:v2 --record=True

else   
echo "Creating............";
wget -N https://raw.githubusercontent.com/gurpreet0610/Dockerfile-For-AI-Automation/master/DeloymentFile.yml
kubectl create -f DeloymentFile.yml
kubectl expose -f DeloymentFile.yml --port=80 --type=NodePort
port_var=$(kubectl get svc web-deployment -o=jsonpath='{.spec.ports[?(@.port==80)].nodePort}')
echo Web-Address = 192.168.99.100:$port_var
fi
