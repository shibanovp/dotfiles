from locust import HttpUser, task


class HealthcheckUser(HttpUser):
    @task
    def health_and_ready_check(self):
        self.client.get("/api/healthz")
        self.client.get("/api/readyz")
