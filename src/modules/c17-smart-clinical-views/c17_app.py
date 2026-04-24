# FILE: src/modules/c17-smart-clinical-views/c17_app.py
import streamlit as st
import sys
import os

# Ensure the module's own directory is on the path for relative imports
sys.path.insert(0, os.path.dirname(__file__))

from dashboard_logic import render_smart_views

st.set_page_config(page_title="C17 Demo", layout="wide")
st.title("Module C17: Smart Clinical Views - Presentation Mode")
st.sidebar.success("Logged in as: Doctor (Simulation)")

render_smart_views()
