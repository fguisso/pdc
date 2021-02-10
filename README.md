# pdc - ProjectDiscovery Container

## Build the container

```bash
git clone https://github.com/fguisso/pdc
cd pdc
docker build -t pdc .
```

## Usage

You can use this container with interactive mode:
```bash
docker run --rm -it pdc bash
```
exemples:
- `subfinder -d target.com`
- `echo "target.com" | subfinder -silent | nuclei -t vulnerabilities/`
- `echo "target.com" | subfinder -silent | dnsx -silent | naabu -silent | httpx -silent | nuclei -t cves/`

or use one command without attach the container to get the stdout:
```bash
docker run --rm pdc subfinder -d target.com
```
