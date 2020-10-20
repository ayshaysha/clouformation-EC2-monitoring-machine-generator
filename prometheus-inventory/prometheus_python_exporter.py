import time
import requests
import http.server
import prometheus_client
from prometheus_client.core import REGISTRY, CounterMetricFamily, GaugeMetricFamily
from prometheus_client import start_http_server
from prometheus_client import Gauge
from prometheus_client import Counter
from prometheus_client import Histogram
from prometheus_client import Summary

METRICS_PORT = 8000
IP = "12.0.0.1:8000"
REQUEST_COUNT = Counter('http_requests_count', "Total HTTP Requets")

class CustomCollector(object):
    def __init__(self):
        pass

    def gauge_res(self):
        gauge = GaugeMetricFamily(
        'avg_response_time_ms',
        'average response time')

        gauge.add_metric(["instance001.us.west.local"], 20)

        yield gauge
        
    def counter_res(self):

        counter = CounterMetricFamily("requests_sent", 'requests made')
        counter.add_metric(["example"], 2000)
        counter.inc()
        yield counter

    def histogram_res(self):

    	histo = Histogram('histo_values','Description')
    	histo.observe(10)

    	yield histo

    def summary_res(self):

    	summary = Summary('summary_reponse', 'Description of summary')
    	s.observe(10)

    	yield summary


if __name__ == '__main__':
    start_http_server(METRICS_PORT)

    REGISTRY.register(CustomCollector(IP))
    while True:
    	time.sleep(1)
