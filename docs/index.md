<center><img src="{{ site.baseurl }}/tutheaderbl.png" alt="Img"></center>

To add images, replace `tutheaderbl1.png` with the file name of any image you upload to your GitHub repository.

### Tutorial Aims

##### 1. Understand the variety of functions in the `dplyr` package and its application to biodiversity data.

##### 2. Learn to creatively combine and manipulate biodiversity tables and spatial data.

##### 3. Become efficient and creative in manipulating species occurrence data and environmental variables.


### Tutorial Steps

##### <a href="#section1">1. Introduction</a>
- <a href="#section2">Prerequisites</a>
- <a href="#section3">Data and Materials</a>

##### <a href="#section2">PART I: Species Occurrence Data</a>
- Combining Rows with `bind_rows`
- Comparing Data with Set Operations
- Combining Tables with Mutating Joins
- Combining Tables with Filtering Joins

##### <a href="#section4">PART II: Environmental Data</a>



### <a name="section1">1. Introduction</a>

Data come in a variety of forms, and understanding how to visualize and analyze them is crucial for uncovering patterns and insights. In the field of biodiversity conservation, mapping biodiversity hotspots is one of the most effective ways to identify areas with high species richness and vulnerability. This tutorial will guide you through the process of working with species occurrence data and environmental data to map these hotspots.

We will focus on Panthera leo (lions) as our example species and use data from the [Global Biodiversity Information Facility (GBIF)](https://www.gbif.org/zh/) for species occurrences and WorldClim for environmental factors. You'll learn how to handle and visualize biodiversity data in `R` using the `dplyr` package for data manipulation, and spatial analysis techniques with `ggplot2` and `raster` to creating informative maps.

#### <a name="section2">Prerequisites</a>

This tutorial is suitable for those with a basic understanding of data manipulation and visualization in `R`. We will cover concepts ranging from basic data cleaning and transformation with `dplyr`, to more advanced spatial analysis with `ggplot2` and `raster`. To make the most of this tutorial, you should be familiar with:

- Data manipulation using `dplyr` and `tidyr`
- Data visualization with `ggplot2`

If you're new to these topics or need a refresher, there are excellent resources available on the Coding Club website:

[Getting started with R and RStudio](https://ourcodingclub.github.io/tutorials/intro-to-r/)

[Basic data manipulation](https://ourcodingclub.github.io/tutorials/data-manip-intro/)

[Beautiful and informative data visualisation](https://ourcodingclub.github.io/tutorials/datavis/)


#### <a name="section3">Data and Materials</a>

You can find all the data that you require for completing this tutorial on this [GitHub repository](https://github.com/EdDataScienceEES/tutorial-xiongshizhao). We encourage you to download the data to your computer and work through the examples throughout the tutorial as this will reinforces your understanding of the concepts taught in the tutorial.

**Now, let's get started with mapping biodiversity hotspots!**








At the beginning of your tutorial you can ask people to open `RStudio`, create a new script by clicking on `File/ New File/ R Script` set the working directory and load some packages, for example `ggplot2` and `dplyr`. You can surround package names, functions, actions ("File/ New...") and small chunks of code with backticks, which defines them as inline code blocks and makes them stand out among the text, e.g. `ggplot2`.

When you have a larger chunk of code, you can paste the whole code in the `Markdown` document and add three backticks on the line before the code chunks starts and on the line after the code chunks ends. After the three backticks that go before your code chunk starts, you can specify in which language the code is written, in our case `R`.

To find the backticks on your keyboard, look towards the top left corner on a Windows computer, perhaps just above `Tab` and before the number one key. On a Mac, look around the left `Shift` key. You can also just copy the backticks from below.

```r
# Set the working directory
setwd("your_filepath")

# Load packages
library(ggplot2)
library(dplyr)
```

<a name="section2"></a>

## 2. The second section

You can add more text and code, e.g.

```r
# Create fake data
x_dat <- rnorm(n = 100, mean = 5, sd = 2)  # x data
y_dat <- rnorm(n = 100, mean = 10, sd = 0.2)  # y data
xy <- data.frame(x_dat, y_dat)  # combine into data frame
```

Here you can add some more text if you wish.

```r
xy_fil <- xy %>%  # Create object with the contents of `xy`
	filter(x_dat < 7.5)  # Keep rows where `x_dat` is less than 7.5
```

And finally, plot the data:

```r
ggplot(data = xy_fil, aes(x = x_dat, y = y_dat)) +  # Select the data to use
	geom_point() +  # Draw scatter points
	geom_smooth(method = "loess")  # Draw a loess curve
```

At this point it would be a good idea to include an image of what the plot is meant to look like so students can check they've done it right. Replace `IMAGE_NAME.png` with your own image file:

<center> <img src="{{ site.baseurl }}/IMAGE_NAME.png" alt="Img" style="width: 800px;"/> </center>

<a name="section1"></a>

## 3. The third section

More text, code and images.

This is the end of the tutorial. Summarise what the student has learned, possibly even with a list of learning outcomes. In this tutorial we learned:

##### - how to generate fake bivariate data
##### - how to create a scatterplot in ggplot2
##### - some of the different plot methods in ggplot2

We can also provide some useful links, include a contact form and a way to send feedback.

For more on `ggplot2`, read the official <a href="https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf" target="_blank">ggplot2 cheatsheet</a>.

Everything below this is footer material - text and links that appears at the end of all of your tutorials.

<hr>
<hr>

#### Check out our <a href="https://ourcodingclub.github.io/links/" target="_blank">Useful links</a> page where you can find loads of guides and cheatsheets.

#### If you have any questions about completing this tutorial, please contact us on ourcodingclub@gmail.com

#### <a href="INSERT_SURVEY_LINK" target="_blank">We would love to hear your feedback on the tutorial, whether you did it in the classroom or online!</a>

<ul class="social-icons">
	<li>
		<h3>
			<a href="https://twitter.com/our_codingclub" target="_blank">&nbsp;Follow our coding adventures on Twitter! <i class="fa fa-twitter"></i></a>
		</h3>
	</li>
</ul>

### &nbsp;&nbsp;Subscribe to our mailing list:
<div class="container">
	<div class="block">
        <!-- subscribe form start -->
		<div class="form-group">
			<form action="https://getsimpleform.com/messages?form_api_token=de1ba2f2f947822946fb6e835437ec78" method="post">
			<div class="form-group">
				<input type='text' class="form-control" name='Email' placeholder="Email" required/>
			</div>
			<div>
                        	<button class="btn btn-default" type='submit'>Subscribe</button>
                    	</div>
                	</form>
		</div>
	</div>
</div>
