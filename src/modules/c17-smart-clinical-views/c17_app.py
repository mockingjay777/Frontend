import streamlit as st
import sys
import os

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from dashboard_logic import render_smart_views

st.set_page_config(page_title="C17 Demo", layout="wide")
st.title("Module C17: Smart Clinical Views - Presentation Mode")
st.sidebar.success("Logged in as: Doctor (Simulation)")

render_smart_views()
