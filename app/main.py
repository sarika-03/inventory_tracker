from fastapi import FastAPI, Request, Form
from fastapi.responses import HTMLResponse
from fastapi.templating import Jinja2Templates
from typing import List
from app.models import Product  # Import Product model

app = FastAPI()
templates = Jinja2Templates(directory="app/template")  # Tell FastAPI where HTML templates are

# In-memory storage for products
products: List[Product] = []

# Home page – list all products
@app.get("/", response_class=HTMLResponse)
def home(request: Request):
    return templates.TemplateResponse("index.html", {"request": request, "products": products})

# Add product page – form
@app.get("/add", response_class=HTMLResponse)
def add_product_page(request: Request):
    return templates.TemplateResponse("add_product.html", {"request": request})

# Handle form submission
@app.post("/add", response_class=HTMLResponse)
def add_product_form(
    request: Request,
    id: int = Form(...),
    name: str = Form(...),
    sku: str = Form(...),
    price: float = Form(...),
    stock: int = Form(...)
):
    # Create Product instance
    product = Product(id=id, name=name, sku=sku, price=price, stock=stock)
    products.append(product)  # Add to in-memory list
    # Return to home page with updated product list
    return templates.TemplateResponse("index.html", {"request": request, "products": products})
