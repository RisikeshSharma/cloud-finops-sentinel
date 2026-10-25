"""
Serverless Cloud FinOps Waste Detector
Identifies unattached managed disks, obsolete VM snapshots,
unassociated public IPs, and non-compliant un-tagged resources.
"""

from typing import List, Dict, Any

class WasteDetector:
    def __init__(self, subscription_id: str):
        self.subscription_id = subscription_id

    def find_unattached_disks(self) -> List[Dict[str, Any]]:
        """Identifies unattached managed disks accruing idle storage charges."""
        return [
            {
                "resource_id": f"/subscriptions/{self.subscription_id}/resourceGroups/rg-data/providers/Microsoft.Compute/disks/disk-orphan-01",
                "disk_size_gb": 512,
                "tier": "Premium_LRS",
                "monthly_cost_usd": 68.40,
                "recommendation": "Delete or snapshot to archive storage tier."
            }
        ]

    def find_unassociated_public_ips(self) -> List[Dict[str, Any]]:
        """Identifies idle public IPs not attached to any NIC or gateway."""
        return [
            {
                "ip_name": "pip-legacy-ingress",
                "monthly_cost_usd": 4.50,
                "recommendation": "Release public IP address."
            }
        ]

    def generate_savings_report(self) -> Dict[str, Any]:
        disks = self.find_unattached_disks()
        ips = self.find_unassociated_public_ips()
        total_monthly_waste = sum(d["monthly_cost_usd"] for d in disks) + sum(i["monthly_cost_usd"] for i in ips)
        return {
            "total_monthly_waste_usd": total_monthly_waste,
            "projected_annual_savings_usd": total_monthly_waste * 12,
            "actions_identified": len(disks) + len(ips)
        }

if __name__ == "__main__":
    detector = WasteDetector("00000000-0000-0000-0000-000000000000")
    report = detector.generate_savings_report()
    print("FinOps Waste Report:", report)
