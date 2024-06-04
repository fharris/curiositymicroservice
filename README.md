Curiosity Microservice
---

This is the code for the microservices version, part of Chapter 8 of the book [Cloud Native Architecture: Efficiently moving legacy applications and monoliths to microservices and Kubernetes](https://amzn.eu/d/cBqJHu9).
The lab was initially conceived to deploy the application on a local Kubernetes cluster. The examples were successfully tested with K3s and Rancher Desktop. I will add more examples and exercises and test it with other Kubernetes local runtimes like minikube. Meanwhile, let us know if you find anything you would like to change, improve or correct!

*Fernando Harris*

---

**Manual deployment**

Install the application manually

[Manual deployment](./manual-deployment.md)

**Automated deployment**

Set up a local full DevOps ecosystem with Jenkins CI/CD pipelines, Gogs as a source code server repository, and Registry to manage the life cycle of container images.

[Automated deployment](./automatic-deployment.md)

