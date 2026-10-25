# 💰 Cloud FinOps Sentinel

[![FinOps CI](https://github.com/RisikeshSharma/cloud-finops-sentinel/actions/workflows/ci.yml/badge.svg)](https://github.com/RisikeshSharma/cloud-finops-sentinel/actions)
[![Infracost Gate](https://img.shields.io/badge/Infracost-Budget_Gated-0284c7?style=flat&logo=infracost)](https://www.infracost.io)
[![Savings](https://img.shields.io/badge/OPEX_Savings-32%25_Verified-16a34a?style=flat)](https://github.com/RisikeshSharma/cloud-finops-sentinel)

Serverless cloud financial management bot automating multi-cloud waste elimination, resource rightsizing, and predictive CI/CD budget gating.

---

## 🧭 Architecture

```mermaid
flowchart LR
    Cron[Timer / EventGrid Trigger] --> Func[Azure Function App\nFinOps Sentinel Core]
    Func --> Disks[Orphan Disks Detector]
    Func --> IPs[Idle Public IPs Detector]
    Func --> Right[Compute Rightsizing Engine]
    Func --> PR[Infracost Budget Check Gate]
    PR --> Slack[Cost Governance Alert / Slack]
```

---

## ⚡ Key Modules & Engineering Patterns

* **Waste Detectors ([`analyzers/waste_detector.py`](./analyzers/waste_detector.py)):** Scans subscriptions for unattached managed disks, obsolete VM snapshots, and idle public IPs.
* **Rightsizing Engine ([`analyzers/rightsizing.py`](./analyzers/rightsizing.py)):** Evaluates CPU/memory p95 percentiles over rolling 14-day windows to recommend SKU downsizing.
* **Terraform Serverless Platform ([`terraform/`](./terraform/)):**
  * Modular Azure Functions, Storage Account, and App Service Plan provisioning.
  * `for_each`: Multi-scan schedule rules and severity levels.
  * Conditional iteration: Infracost CI/CD gate toggles and auto-remediation triggers.

---

## 👤 Author

**Rishikesh Sharma**  
Senior DevSecOps Engineer & Cloud Solutions Architect  
[GitHub Profile](https://github.com/RisikeshSharma) · [LinkedIn](https://linkedin.com)
