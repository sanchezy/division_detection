# division_detection
Cell-division classifier


## Installation

Use docker to run the classifier. Images are available at https://hub.docker.com/r/rueberger/division_detection/.
Docker will pull the latest image at runtime.

### Prereqs

- [Docker](https://docs.docker.com/engine/installation/)
- [Nvidia docker](https://github.com/NVIDIA/nvidia-docker) (for GPU acceleration)


### Data volume

Note: in future releases a script for pulling the data and building the volume will be provided

The base images do not include any data. To use them, put the data you wish into a Docker volume and attach it
at container runtime.

Please refer to online docker documentation on volume creation and usage.

**Set the name of your volume to the environment variable DATA_VOL** such as in the following:

`export DATA_VOL=your_volume_name`

It is used to mount the data volume at container runtime.

### Building the container

The containers may be built for local use by executing

`make cpu_image`

and/or

`make gpu_image`

from the root repo directory.

Note pre-built images are available at the tag `rueberger/division_detection:latest` for the CPU image and
`rueberger/division_detection:latest_gpu` for the GPU image.

## Usage

### Running the image

The following commands download the image if necessary, start them, and drop you into a bash shell. `$DATA_VOL`
is mounted at `/data`.

#### CPU

`docker run --name div_det -it --mount type=volume,source=$DATA_VOL,destination=/data rueberger/division_detection:latest`

#### GPU

##### New `nvidia-docker` runtime

`docker run --runtime=nvidia --name div_det -it --mount type=volume,source=$DATA_VOL,destination=/data rueberger/division_detection:latest_gpu`

##### Old `nvidia-docker`

`nvidia-docker run  --name div_det -it --mount type=volume,source=$DATA_VOL,destination=/data rueberger/division_detection:latest_gpu`

### Running the included example 

As script for pulling example data is included. Here is how to use it:

1. Run the download script: 

   ``` source division_detection/scripts/fetch_data.sh  ```
   
   This downloads the example data set into `~/data/division_detection/klb`

2. Run the container, mounting the data where expected:

   ``` docker run --runtime=nvidia --name div_det -it --mount type=bind,source=~/data/division_detection,destination=/data rueberger/division_detection:latest_gpu python division_detection/scripts/predict.py  /data```
   
   Notes:
      * `~/` needs to expanded to the absolute path for `source=`
      *  Notice that here we use a bind-mount instead of putting the data in a proper volume as discussed above=. Doesn't matter to the container.  

### Generating predictions

A script is provided for running predictions at `scripts/predict.py`. For now, run it with `python predict.py` - usage instructions will be printed.

Later releases will automatically add a system wide alias for this.

The most basic usage is

`python predict.py /data/path`

The directory `/data/path` should contain only a directory named `klb` which contains the klb files you wish to process.

## Training

This release officially supports prediction only. While all code used to train the model is included and has inline
docstrings, it has not been tested and high level docs are not available at this time.

**Training will be supported in future releases**. We aim to release a fully featured package for machine
learning on spatiotemporal bioimagery in 2018.

## Disclaimer

> THIS SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
