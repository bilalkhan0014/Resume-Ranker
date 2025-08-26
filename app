import streamlit as st
from resume_processor import extract_text_from_pdf
from score_scheck import get_resume_score

st.title("Resume Ranker with Azure LLM")

jd_file = st.file_uploader("Upload Job Description (PDF)", type = ["pdf"])
resume_files = st.file_uploader("Upload 10 resume Pdfs", type = ["pdf"],accept_multiple_files=True)

if jd_file and resume_files:
    with st.spinner("Extracting JD..."):
        jd_text = extract_text_from_pdf(jd_file)
    
    results = []
    for resume_file in resume_files:
        with st.spinner(f"Scoring {resume_file.name}..."):
            resume_text = extract_text_from_pdf(resume_file)
            score = get_resume_score(resume_text,jd_text)
            results.append((resume_file.name,score))

    results.sort(key=lambda x: x[1],reverse=True)
    
    st.success("Ranking Complete")
    st.subheader("Ranked Resumes")
    for name , score in results:
        st.write(f"{name}** - Score:{score}")
