FROM nginx

# Copy data for add-on
COPY run.sh /
#COPY index.html /
RUN chmod a+x /run.sh
#RUN chmod a+x /index.html
CMD [ "/run.sh" ]
