from langchain_openai import AzureChatOpenAI
from langchain.schema import HumanMessage
import os 
def get_resume_score(resume_text,jd_text):
    llm = AzureChatOpenAI(
        azure_endpoint=os.getenv("AZUREOPENAI_API_BASE"),
        openai_api_version=os.getenv("AZURE_OPENAI_API_VERSION"),
        openai_api_key=os.getenv("AZURE_OPENAI_API_KEY"),
        deployment_name=os.getenv("AZURE_OPENAI_DEPLOYMENT_NAME"),
        model_name="gpt-4o",
        temperature=0.3
)
    
    prompt = f"""
    You are a recruiter. Compare the following resume with the job description and give a relevance score from 0 to 100.

    Job Description:
    {jd_text}

    Resume:
    {resume_text}

    Score only in this format: SCORE:<number>

"""
    response = llm([HumanMessage(content=prompt)])
    score_line = response.content.strip()

    try:
        score = int(score_line.split(":")[-1])
    except:
        score = 0

    return score
